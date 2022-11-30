module Graphql.Http exposing
    ( Request, HttpError(..), Error, RawError(..)
    , queryRequest, mutationRequest, queryRequestWithHttpGet
    , QueryRequestMethod(..)
    , withHeader, withTimeout, withCredentials, withQueryParams, withOperationName
    , send, sendWithTracker, toTask
    , mapError, discardParsedErrorData, withSimpleHttpError
    , parseableErrorAsSuccess
    )

{-| Send requests to your GraphQL endpoint. See [this live code demo](https://rebrand.ly/graphqelm)
or the [`examples/`](https://github.com/dillonkearns/elm-graphql/tree/master/examples)
folder for some end-to-end examples.
The builder syntax is inspired by Luke Westby's
[elm-http-builder package](http://package.elm-lang.org/packages/lukewestby/elm-http-builder/latest).


## Data Types

@docs Request, HttpError, Error, RawError


## Begin `Request` Pipeline

@docs queryRequest, mutationRequest, queryRequestWithHttpGet
@docs QueryRequestMethod


## Configure `Request` Options

@docs withHeader, withTimeout, withCredentials, withQueryParams, withOperationName


## Perform `Request`

@docs send, sendWithTracker, toTask


## Map `Error`s

@docs mapError, discardParsedErrorData, withSimpleHttpError


## Error Handling Strategies

There are 3 possible strategies to handle GraphQL errors.

1.  **`parseableErrorAsSuccess`** If there is a GraphQL error (and the data was
    complete enough for the decoder to run successfully), pretend that there was
    no error at all.
2.  **Not Implemented** If there is a GraphQL error pretend it was a network error.
    There is currently no implementation for this strategy, if you think this
    would come in handy, please open a Github issue to describe your use case!
3.  **Default** This gives you full control. You get an accurate and exact
    picture of what happened (got a GraphQL error & could parse the body, got a
    GraphQL error and couldn't parse the body, got an http error, or got
    everything was successful). And you can handle each case explicitly.

@docs parseableErrorAsSuccess

-}

import Graphql.Document as Document
import Graphql.Http.GraphqlError as GraphqlError
import Graphql.Http.QueryHelper as QueryHelper
import Graphql.Http.QueryParams as QueryParams
import Graphql.Operation exposing (RootMutation, RootQuery)
import Graphql.SelectionSet exposing (SelectionSet)
import Http
import Json.Decode
import Json.Encode
import Task exposing (Task)


{-| An internal request as it's built up. Once it's built up, send the
request with `Graphql.Http.send`.
-}
type Request decodesTo
    = Request
        { details : Details decodesTo
        , headers : List Http.Header
        , baseUrl : String
        , expect : Json.Decode.Decoder decodesTo
        , timeout : Maybe Float
        , withCredentials : Bool
        , queryParams : List ( String, String )
        , operationName : Maybe String
        }


type alias ReadyRequest decodesTo =
    { method : String
    , headers : List Http.Header
    , url : String
    , body : Http.Body
    , timeout : Maybe Float
    , decoder : Json.Decode.Decoder (DataResult decodesTo)
    }


{-| Union type to pass in to `queryRequestWithHttpGet`. Only applies to queries.
Mutations don't accept this configuration option and will always use POST.
-}
type QueryRequestMethod
    = AlwaysGet
    | GetIfShortEnough


type Details decodesTo
    = Query (Maybe QueryRequestMethod) (SelectionSet decodesTo RootQuery)
    | Mutation (SelectionSet decodesTo RootMutation)


{-| Initialize a basic request from a Query. You can add on options with `withHeader`,
`withTimeout`, `withCredentials`, and send it with `Graphql.Http.send`.
-}
queryRequest : String -> SelectionSet decodesTo RootQuery -> Request decodesTo
queryRequest baseUrl query =
    { headers = []
    , baseUrl = baseUrl
    , expect = Document.decoder query
    , timeout = Nothing
    , withCredentials = False
    , details = Query Nothing query
    , queryParams = []
    , operationName = Nothing
    }
        |> Request


{-| Exactly like `queryRequest`, but with an option to use the HTTP GET request
method. You will probably want to use `GetIfShortEnough`, which uses GET if the
full URL ends up being under 2000 characters, or POST otherwise, since [some browsers
don't support URLs over a certain length](https://stackoverflow.com/questions/812925/what-is-the-maximum-possible-length-of-a-query-string?noredirect=1&lq=1).
`GetIfShortEnough` will typically do what you need. If you must use GET no matter
what when hitting your endpoint, you can use `AlwaysGet`.

`queryRequest` always uses POST since some GraphQL API's don't support GET
requests (for example, the Github API assumes that you are doing an introspection
query if you make a GET request). But for semantic reasons, GET requests
are sometimes useful for sending GraphQL Query requests. That is, a GraphQL Query
does not perform side-effects on the server like a Mutation does, so a GET
indicates this and allows some servers to cache requests. See
[this github thread from the Apollo project](https://github.com/apollographql/apollo-client/issues/813)
for more details.

-}
queryRequestWithHttpGet : String -> QueryRequestMethod -> SelectionSet decodesTo RootQuery -> Request decodesTo
queryRequestWithHttpGet baseUrl requestMethod query =
    { headers = []
    , baseUrl = baseUrl
    , expect = Document.decoder query
    , timeout = Nothing
    , withCredentials = False
    , details = Query (Just requestMethod) query
    , queryParams = []
    , operationName = Nothing
    }
        |> Request


{-| Initialize a basic request from a Mutation. You can add on options with `withHeader`,
`withTimeout`, `withCredentials`, and send it with `Graphql.Http.send`.
-}
mutationRequest : String -> SelectionSet decodesTo RootMutation -> Request decodesTo
mutationRequest baseUrl mutationSelectionSet =
    { details = Mutation mutationSelectionSet
    , headers = []
    , baseUrl = baseUrl
    , expect = Document.decoder mutationSelectionSet
    , timeout = Nothing
    , withCredentials = False
    , queryParams = []
    , operationName = Nothing
    }
        |> Request


{-| Set an operation name. This is a meaningful and explicit name for your operation,
very helpful for debugging and server-side logging.
See <https://graphql.org/learn/queries/#operation-name>

    makeRequest : Cmd Msg
    makeRequest =
        query
            |> Graphql.Http.queryRequest "https://api.github.com/graphql"
            |> Graphql.Http.withOperationName "HeroNameAndFriends"
            |> Graphql.Http.send (RemoteData.fromResult >> GotResponse)

-}
withOperationName : String -> Request decodesTo -> Request decodesTo
withOperationName operationName (Request request) =
    Request { request | operationName = Just operationName }


{-| An alias for the default kind of Error. See the `RawError` for the full
type.
-}
type alias Error parsedData =
    RawError parsedData HttpError


{-| Represents the two types of errors you can get, an Http error or a GraphQL error.
See the `Graphql.Http.GraphqlError` module docs for more details.
-}
type RawError parsedData httpError
    = GraphqlError (GraphqlError.PossiblyParsedData parsedData) (List GraphqlError.GraphqlError)
    | HttpError httpError


toSimpleHttpError : HttpError -> Http.Error
toSimpleHttpError httpError =
    case httpError of
        BadUrl url ->
            Http.BadUrl url

        Timeout ->
            Http.Timeout

        NetworkError ->
            Http.NetworkError

        BadStatus metadata body ->
            Http.BadStatus metadata.statusCode

        BadPayload jsonError ->
            Http.BadBody (Json.Decode.errorToString jsonError)


{-| An Http Error. A Request can fail in a few ways:

  - `BadUrl` means you did not provide a valid URL.
  - `Timeout` means it took too long to get a response.
  - `NetworkError` means the user turned off their wifi, went in a cave, etc.
  - `BadStatus` means you got a response back, but the status code indicates failure. The second argument in the payload is the response body.
  - `BadPayload` means you got a response back with a nice status code, but the body of the response was something unexpected. The String in this case is a debugging message that explains what went wrong with your JSON decoder or whatever.

-}
type HttpError
    = BadUrl String
    | Timeout
    | NetworkError
    | BadStatus Http.Metadata String
    | BadPayload Json.Decode.Error


{-| Map the error data if it is `ParsedData`.
-}
mapError : (a -> b) -> Error a -> Error b
mapError mapFn error =
    case error of
        GraphqlError possiblyParsedData graphqlErrorList ->
            case possiblyParsedData of
                GraphqlError.ParsedData parsedData ->
                    GraphqlError (GraphqlError.ParsedData (mapFn parsedData)) graphqlErrorList

                GraphqlError.UnparsedData unparsedData ->
                    GraphqlError (GraphqlError.UnparsedData unparsedData) graphqlErrorList

        HttpError httpError ->
            HttpError httpError


{-| Useful when you want to combine together an Http response with a Graphql
request response.

    -- this is just the type that our query decodes to
    type alias Response =
        { hello : String }

    type Msg
        = GotResponse (RemoteData (Graphql.Http.RawError Response Http.Error) Response)

    request =
        query
            |> Graphql.Http.queryRequest "https://some-graphql-api.com"
            |> Graphql.Http.send
                (Graphql.Http.withSimpleHttpError
                    >> RemoteData.fromResult
                    >> GotResponse
                )

    combinedResponses =
        RemoteData.map2 Tuple.pair
            model.graphqlResponse
            (model.plainHttpResponse |> RemoteData.mapError Graphql.Http.HttpError)

-}
withSimpleHttpError : Result (Error parsedData) decodesTo -> Result (RawError parsedData Http.Error) decodesTo
withSimpleHttpError result =
    case result of
        Ok decodesTo ->
            Ok decodesTo

        Err error ->
            case error of
                HttpError httpError ->
                    httpError |> toSimpleHttpError |> HttpError |> Err

                GraphqlError possiblyParsed graphqlErrorList ->
                    GraphqlError possiblyParsed graphqlErrorList |> Err


{-| Useful when you don't want to deal with the recovered data if there is `ParsedData`.
Just a shorthand for `mapError` that will turn any `ParsedData` into `()`.

This is helpful if you want to simplify your types, or if you are combining multiple
results together and you need the error types to line up (but you don't care about
recovering parsed data when there are GraphQL errors in the response).

In the examples below, notice the error type is now `(Graphql.Http.Error ())`.

You can use this when you call `Graphql.Http.send` like so:

    import Graphql.Http

    type Msg
        = GotResponse (Result (Graphql.Http.Error ()) Response)

    makeRequest =
        query
            |> Graphql.Http.queryRequest "http://elm-graphql.herokuapp.com"
            |> Graphql.Http.send
                (Graphql.Http.discardParsedErrorData
                    >> RemoteData.fromResult
                    >> GotResponse
                )

Or if you are using the RemoteData package:

    import Graphql.Http
    import RemoteData exposing (RemoteData)

    type Msg
        = GotResponse (RemoteData (Graphql.Http.Error ()) Response)

    makeRequest =
        query
            |> Graphql.Http.queryRequest "http://elm-graphql.herokuapp.com"
            |> Graphql.Http.send
                (Graphql.Http.discardParsedErrorData
                    >> RemoteData.fromResult
                    >> GotResponse
                )

-}
discardParsedErrorData : Result (Error decodesTo) decodesTo -> Result (Error a) decodesTo
discardParsedErrorData result =
    case result of
        Ok data ->
            Ok data

        Err (HttpError httpError) ->
            Err (HttpError httpError)

        Err (GraphqlError (GraphqlError.ParsedData parsed) errorList) ->
            Err (GraphqlError (GraphqlError.UnparsedData Json.Encode.null) errorList)

        Err (GraphqlError (GraphqlError.UnparsedData value) errorList) ->
            Err (GraphqlError (GraphqlError.UnparsedData value) errorList)


{-| WARNING: When using this function you lose information. Make sure this is
the approach you want before using this.

Treat responses with GraphQL errors as successful responses if the data can
be parsed. If you want to use the successfully decoded data without ignoring the
GraphQL error you can do a pattern match on the `Graphql.Http.Error` type
(it contains `PossiblyParsedData` which is either unparsed with a raw
`Json.Decode.Value` or else it contains successfully decoded data).

-}
parseableErrorAsSuccess : Result (Error decodesTo) decodesTo -> Result (Error ()) decodesTo
parseableErrorAsSuccess result =
    case result of
        Ok value ->
            Ok value

        Err error ->
            case error of
                GraphqlError possiblyParsedData errors ->
                    case possiblyParsedData of
                        GraphqlError.ParsedData parsedData ->
                            Ok parsedData

                        GraphqlError.UnparsedData jsonValue ->
                            GraphqlError (GraphqlError.UnparsedData jsonValue) errors
                                |> Err

                HttpError httpError ->
                    HttpError httpError
                        |> Err


type alias DataResult parsedData =
    Result ( GraphqlError.PossiblyParsedData parsedData, List GraphqlError.GraphqlError ) parsedData


convertResult : Result HttpError (DataResult decodesTo) -> Result (Error decodesTo) decodesTo
convertResult httpResult =
    case httpResult of
        Ok successOrError ->
            case successOrError of
                Ok value ->
                    Ok value

                Err ( possiblyParsedData, error ) ->
                    Err (GraphqlError possiblyParsedData error)

        Err httpError ->
            Err (HttpError httpError)


{-| Send the `Graphql.Request`
You can use it on its own, or with a library like
[RemoteData](http://package.elm-lang.org/packages/krisajenkins/remotedata/latest/).

    import Graphql.Http
    import Graphql.OptionalArgument exposing (OptionalArgument(..))
    import RemoteData exposing (RemoteData)

    type Msg
        = GotResponse RemoteData (Graphql.Http.Error Response) Response

    makeRequest : Cmd Msg
    makeRequest =
        query
            |> Graphql.Http.queryRequest "https://elm-graphql.onrender.com/"
            |> Graphql.Http.withHeader "authorization" "Bearer abcdefgh12345678"
            -- If you're not using remote data, it's just
            -- |> Graphql.Http.send GotResponse
            -- With remote data, it's as below
            |> Graphql.Http.send (RemoteData.fromResult >> GotResponse)

If any errors are present, you will get a `GraphqlError` that includes the details.
GraphQL allows for partial data to be returned in the case of errors so you can
inspect the data returned in the `GraphqlError` if you would like to try to recover
any data that made it through in the response.

-}
send : (Result (Error decodesTo) decodesTo -> msg) -> Request decodesTo -> Cmd msg
send resultToMessage ((Request request) as fullRequest) =
    fullRequest
        |> toHttpRequestRecord resultToMessage
        |> (if request.withCredentials then
                Http.riskyRequest

            else
                Http.request
           )


{-| Exactly like `Graphql.Http.request` except it allows you to use the `String`
passed in as the tracker to [`track`](https://package.elm-lang.org/packages/elm/http/2.0.0/Http#track)
and [`cancel`](https://package.elm-lang.org/packages/elm/http/2.0.0/Http#cancel)
requests using the core Elm `Http` package (see
[the `Http.request` docs](https://package.elm-lang.org/packages/elm/http/2.0.0/Http#request))
-}
sendWithTracker : String -> (Result (Error decodesTo) decodesTo -> msg) -> Request decodesTo -> Cmd msg
sendWithTracker tracker resultToMessage ((Request request) as fullRequest) =
    fullRequest
        |> toHttpRequestRecord resultToMessage
        |> (\requestRecord -> { requestRecord | tracker = Just tracker })
        |> (if request.withCredentials then
                Http.riskyRequest

            else
                Http.request
           )


toHttpRequestRecord :
    (Result (Error decodesTo) decodesTo -> msg)
    -> Request decodesTo
    ->
        { method : String
        , headers : List Http.Header
        , url : String
        , body : Http.Body
        , expect : Http.Expect msg
        , timeout : Maybe Float
        , tracker : Maybe String
        }
toHttpRequestRecord resultToMessage ((Request request) as fullRequest) =
    fullRequest
        |> toReadyRequest
        |> (\readyRequest ->
                { method = readyRequest.method
                , headers = readyRequest.headers
                , url = readyRequest.url
                , body = readyRequest.body
                , expect = expectJson (convertResult >> resultToMessage) readyRequest.decoder
                , timeout = readyRequest.timeout
                , tracker = Nothing
                }
           )


expectJson : (Result HttpError decodesTo -> msg) -> Json.Decode.Decoder decodesTo -> Http.Expect msg
expectJson toMsg decoder =
    Http.expectStringResponse toMsg <|
        \response ->
            case response of
                Http.BadUrl_ url ->
                    BadUrl url |> Err

                Http.Timeout_ ->
                    Timeout |> Err

                Http.NetworkError_ ->
                    NetworkError |> Err

                Http.BadStatus_ metadata body ->
                    BadStatus metadata body |> Err

                Http.GoodStatus_ metadata body ->
                    case Json.Decode.decodeString decoder body of
                        Ok value ->
                            Ok value

                        Err err ->
                            BadPayload err |> Err


jsonResolver : Json.Decode.Decoder decodesTo -> Http.Resolver HttpError decodesTo
jsonResolver decoder =
    Http.stringResolver <|
        \response ->
            case response of
                Http.BadUrl_ url ->
                    BadUrl url |> Err

                Http.Timeout_ ->
                    Timeout |> Err

                Http.NetworkError_ ->
                    NetworkError |> Err

                Http.BadStatus_ metadata body ->
                    BadStatus metadata body |> Err

                Http.GoodStatus_ metadata body ->
                    case Json.Decode.decodeString decoder body of
                        Ok value ->
                            Ok value

                        Err err ->
                            BadPayload err |> Err


toReadyRequest : Request decodesTo -> ReadyRequest decodesTo
toReadyRequest (Request request) =
    case request.details of
        Query forcedRequestMethod querySelectionSet ->
            let
                queryRequestDetails =
                    QueryHelper.build
                        (case forcedRequestMethod of
                            Just AlwaysGet ->
                                Just QueryHelper.Get

                            Just GetIfShortEnough ->
                                Nothing

                            Nothing ->
                                Just QueryHelper.Post
                        )
                        request.baseUrl
                        request.queryParams
                        request.operationName
                        querySelectionSet
            in
            { method =
                case queryRequestDetails.method of
                    QueryHelper.Get ->
                        "GET"

                    QueryHelper.Post ->
                        "Post"
            , headers = request.headers
            , url = queryRequestDetails.url
            , body = queryRequestDetails.body
            , decoder = decoderOrError request.expect
            , timeout = request.timeout
            }

        Mutation mutationSelectionSet ->
            let
                serializedMutation =
                    case request.operationName of
                        Just operationName ->
                            Document.serializeMutationWithOperationName operationName mutationSelectionSet

                        Nothing ->
                            Document.serializeMutation mutationSelectionSet
            in
            { method = "POST"
            , headers = request.headers
            , url = request.baseUrl |> QueryParams.urlWithQueryParams request.queryParams
            , body =
                Http.jsonBody
                    (Json.Encode.object
                        (List.append
                            [ ( "query"
                              , Json.Encode.string serializedMutation
                              )
                            ]
                            (case request.operationName of
                                Just operationName ->
                                    [ ( "operationName"
                                      , Json.Encode.string operationName
                                      )
                                    ]

                                Nothing ->
                                    []
                            )
                        )
                    )
            , decoder = decoderOrError request.expect
            , timeout = request.timeout
            }


{-| Convert a Request to a Task. See `Graphql.Http.send` for an example of
how to build up a Request.
-}
toTask : Request decodesTo -> Task (Error decodesTo) decodesTo
toTask ((Request request) as fullRequest) =
    fullRequest
        |> toReadyRequest
        |> (\readyRequest ->
                (if request.withCredentials then
                    Http.riskyTask

                 else
                    Http.task
                )
                    { method = readyRequest.method
                    , headers = readyRequest.headers
                    , url = readyRequest.url
                    , body = readyRequest.body
                    , resolver = resolver fullRequest
                    , timeout = readyRequest.timeout
                    }
           )
        |> Task.mapError HttpError
        |> Task.andThen failTaskOnHttpSuccessWithErrors


resolver : Request decodesTo -> Http.Resolver HttpError (DataResult decodesTo)
resolver request =
    request
        |> toReadyRequest
        |> .decoder
        |> jsonResolver


failTaskOnHttpSuccessWithErrors : DataResult decodesTo -> Task (Error decodesTo) decodesTo
failTaskOnHttpSuccessWithErrors successOrError =
    case successOrError of
        Ok value ->
            Task.succeed value

        Err ( possiblyParsedData, graphqlErrorGraphqlErrorList ) ->
            Task.fail (GraphqlError possiblyParsedData graphqlErrorGraphqlErrorList)


decoderOrError : Json.Decode.Decoder a -> Json.Decode.Decoder (DataResult a)
decoderOrError decoder =
    Json.Decode.oneOf
        [ errorDecoder decoder
        , decoder |> Json.Decode.map Ok
        ]


errorDecoder : Json.Decode.Decoder a -> Json.Decode.Decoder (DataResult a)
errorDecoder decoder =
    Json.Decode.oneOf
        [ decoder
            |> Json.Decode.map GraphqlError.ParsedData
            |> Json.Decode.andThen decodeErrorWithData
        , Json.Decode.field "data" Json.Decode.value
            |> Json.Decode.map GraphqlError.UnparsedData
            |> Json.Decode.andThen decodeErrorWithData
        , Json.Decode.succeed (GraphqlError.UnparsedData (nullJsonValue ()))
            |> Json.Decode.andThen decodeErrorWithData
        ]


nullJsonValue : () -> Json.Decode.Value
nullJsonValue a =
    case Json.Decode.decodeString Json.Decode.value "null" of
        Ok value ->
            value

        Err _ ->
            nullJsonValue ()


decodeErrorWithData : GraphqlError.PossiblyParsedData a -> Json.Decode.Decoder (DataResult a)
decodeErrorWithData data =
    GraphqlError.decoder |> Json.Decode.map (Tuple.pair data) |> Json.Decode.map Err


{-| Add a header.

    makeRequest : Cmd Msg
    makeRequest =
        query
            |> Graphql.Http.queryRequest "https://api.github.com/graphql"
            |> Graphql.Http.withHeader "authorization" "Bearer <my token>"
            |> Graphql.Http.send (RemoteData.fromResult >> GotResponse)

-}
withHeader : String -> String -> Request decodesTo -> Request decodesTo
withHeader key value (Request request) =
    Request { request | headers = Http.header key value :: request.headers }


{-| Add query params. The values will be Uri encoded.

    makeRequest : Cmd Msg
    makeRequest =
        query
            |> Graphql.Http.queryRequest "https://api.github.com/graphql"
            |> Graphql.Http.withQueryParams [ ( "version", "1.2.3" ) ]
            |> Graphql.Http.send (RemoteData.fromResult >> GotResponse)

-}
withQueryParams : List ( String, String ) -> Request decodesTo -> Request decodesTo
withQueryParams additionalQueryParams (Request request) =
    Request { request | queryParams = request.queryParams ++ additionalQueryParams }


{-| Add a timeout.
-}
withTimeout : Float -> Request decodesTo -> Request decodesTo
withTimeout timeout (Request request) =
    Request { request | timeout = Just timeout }


{-| Set with credentials to true. See [the `XMLHttpRequest/withCredentials` docs](https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/withCredentials)
to understand exactly what happens.

Under the hood, this will use either [`Http.riskyRequest`](https://package.elm-lang.org/packages/elm/http/latest/Http#riskyRequest)
or [`Http.riskyTask`](https://package.elm-lang.org/packages/elm/http/latest/Http#riskyTask).

-}
withCredentials : Request decodesTo -> Request decodesTo
withCredentials (Request request) =
    Request { request | withCredentials = True }
