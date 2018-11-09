module Graphql.Http exposing
    ( Request, Error(..)
    , queryRequest, mutationRequest, queryRequestWithHttpGet
    , QueryRequestMethod(..)
    , withHeader, withTimeout, withCredentials, withQueryParams
    , send, toTask
    , mapError, ignoreParsedErrorData, fromHttpError
    , withOperationName
    )

{-| Send requests to your GraphQL endpoint. See [this live code demo](https://rebrand.ly/graphqelm)
or the [`examples/`](https://github.com/dillonkearns/elm-graphql/tree/master/examples)
folder for some end-to-end examples.
The builder syntax is inspired by Luke Westby's
[elm-http-builder package](http://package.elm-lang.org/packages/lukewestby/elm-http-builder/latest).


## Data Types

@docs Request, Error


## Begin `Request` Pipeline

@docs queryRequest, mutationRequest, queryRequestWithHttpGet
@docs QueryRequestMethod


## Configure `Request` Options

@docs withHeader, withTimeout, withCredentials, withQueryParams


## Perform `Request`

@docs send, toTask


## Map `Error`s

@docs mapError, ignoreParsedErrorData, fromHttpError

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


{-| Represents the two types of errors you can get, an Http error or a GraphQL error.
See the `Graphql.Http.GraphqlError` module docs for more details.
-}
type Error parsedData
    = GraphqlError (GraphqlError.PossiblyParsedData parsedData) (List GraphqlError.GraphqlError)
    | HttpError Http.Error


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


{-| Turn an `Http.Error` into a `Graphql.Http.Error`.
-}
fromHttpError : Http.Error -> Error ()
fromHttpError httpError =
    HttpError httpError


{-| Useful when you don't want to deal with the recovered data if there is `ParsedData`.
Just a shorthand for `mapError` that will turn any `ParsedData` into `()`.
-}
ignoreParsedErrorData : Error parsedData -> Error ()
ignoreParsedErrorData error =
    mapError (\_ -> ()) error


type alias DataResult parsedData =
    Result ( GraphqlError.PossiblyParsedData parsedData, List GraphqlError.GraphqlError ) parsedData


convertResult : Result Http.Error (DataResult decodesTo) -> Result (Error decodesTo) decodesTo
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
            |> Graphql.Http.queryRequest "https://elm-graphql.herokuapp.com/"
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
send resultToMessage elmGraphqlRequest =
    elmGraphqlRequest
        |> toRequest
        |> Http.send (convertResult >> resultToMessage)


toRequest : Request decodesTo -> Http.Request (DataResult decodesTo)
toRequest (Request request) =
    (case request.details of
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
                        request.operationName
                        request.queryParams
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
            , expect = Http.expectJson (decoderOrError request.expect)
            , timeout = request.timeout
            , withCredentials = request.withCredentials
            }

        Mutation mutationSelectionSet ->
            { method = "POST"
            , headers = request.headers
            , url = request.baseUrl |> QueryParams.urlWithQueryParams request.queryParams
            , body =
                Http.jsonBody
                    (Json.Encode.object
                        [ ( "query"
                          , Json.Encode.string (Document.serializeMutation request.operationName mutationSelectionSet)
                          )
                        ]
                    )
            , expect = Http.expectJson (decoderOrError request.expect)
            , timeout = request.timeout
            , withCredentials = request.withCredentials
            }
    )
        |> Http.request


{-| Convert a Request to a Task. See `Graphql.Http.send` for an example of
how to build up a Request.
-}
toTask : Request decodesTo -> Task (Error decodesTo) decodesTo
toTask request =
    request
        |> toRequest
        |> Http.toTask
        |> Task.mapError HttpError
        |> Task.andThen failTaskOnHttpSuccessWithErrors


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
        [ decoder |> Json.Decode.map GraphqlError.ParsedData |> Json.Decode.andThen decodeErrorWithData
        , Json.Decode.field "data" Json.Decode.value |> Json.Decode.map GraphqlError.UnparsedData |> Json.Decode.andThen decodeErrorWithData
        ]


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


{-| Set with credentials to true.
-}
withCredentials : Request decodesTo -> Request decodesTo
withCredentials (Request request) =
    Request { request | withCredentials = True }


withOperationName : String -> Request decodesTo -> Request decodesTo
withOperationName operationName (Request request) =
    Request { request | operationName = Just operationName }
