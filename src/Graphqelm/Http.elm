module Graphqelm.Http exposing (Error(..), Request, mutationRequest, queryRequest, send, toTask, withCredentials, withHeader, withTimeout)

{-| Send requests to your GraphQL endpoint. See [this live code demo](https://rebrand.ly/graphqelm)
or the [`examples/`](https://github.com/dillonkearns/graphqelm/tree/master/examples)
folder for some end-to-end examples.
The builder syntax is inspired by Luke Westby's
[elm-http-builder package](http://package.elm-lang.org/packages/lukewestby/elm-http-builder/latest).


## Data Types

@docs Request, Error


## Begin `Request` Pipeline

@docs queryRequest, mutationRequest


## Configure `Request` Options

@docs withHeader, withTimeout, withCredentials


## Perform `Request`

@docs send, toTask

-}

import Graphqelm.Document as Document
import Graphqelm.Document.LowLevel as Document
import Graphqelm.Http.GraphqlError as GraphqlError
import Graphqelm.Http.QueryHelper as QueryHelper
import Graphqelm.Operation exposing (RootMutation, RootQuery)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Http
import Json.Decode
import Json.Encode
import Task exposing (Task)
import Time exposing (Time)


{-| An internal request as it's built up. Once it's built up, send the
request with `Graphqelm.Http.send`.
-}
type Request decodesTo
    = Request
        { details : Details decodesTo
        , headers : List Http.Header
        , baseUrl : String
        , expect : Json.Decode.Decoder decodesTo
        , timeout : Maybe Time
        , withCredentials : Bool
        , queryParams : List ( String, String )
        }


type Details decodesTo
    = Query (SelectionSet decodesTo RootQuery)
    | Mutation (SelectionSet decodesTo RootMutation)


{-| Initialize a basic request from a Query. You can add on options with `withHeader`,
`withTimeout`, `withCredentials`, and send it with `Graphqelm.Http.send`.
-}
queryRequest : String -> SelectionSet decodesTo RootQuery -> Request decodesTo
queryRequest baseUrl query =
    { headers = []
    , baseUrl = baseUrl
    , expect = Document.decoder query
    , timeout = Nothing
    , withCredentials = False
    , details = Query query
    , queryParams = []
    }
        |> Request


{-| Initialize a basic request from a Mutation. You can add on options with `withHeader`,
`withTimeout`, `withCredentials`, and send it with `Graphqelm.Http.send`.
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
    }
        |> Request


{-| Represents the two types of errors you can get, an Http error or a GraphQL error.
See the `Graphqelm.Http.GraphqlError` module docs for more details.
-}
type Error
    = GraphqlError (List GraphqlError.GraphqlError)
    | HttpError Http.Error


type SuccessOrError a
    = Success a
    | ErrorThing (List GraphqlError.GraphqlError)


convertResult : Result Http.Error (SuccessOrError a) -> Result Error a
convertResult httpResult =
    case httpResult of
        Ok successOrError ->
            case successOrError of
                Success value ->
                    Ok value

                ErrorThing error ->
                    Err (GraphqlError error)

        Err httpError ->
            Err (HttpError httpError)


{-| Send the `Graphqelm.Request`
You can use it on its own, or with a library like
[RemoteData](http://package.elm-lang.org/packages/krisajenkins/remotedata/latest/).

    import Graphqelm.Http
    import Graphqelm.OptionalArgument exposing (OptionalArgument(Null, Present))
    import RemoteData exposing (RemoteData)

    type Msg
        = GotResponse RemoteData Graphqelm.Http.Error Response

    makeRequest : Cmd Msg
    makeRequest =
        query
            |> Graphqelm.Http.queryRequest "https://graphqelm.herokuapp.com/"
            |> Graphqelm.Http.withHeader "authorization" "Bearer abcdefgh12345678"
            -- If you're not using remote data, it's just
            -- |> Graphqelm.Http.send GotResponse
            -- With remote data, it's as below
            |> Graphqelm.Http.send (RemoteData.fromResult >> GotResponse)

-}
send : (Result Error a -> msg) -> Request a -> Cmd msg
send resultToMessage graphqelmRequest =
    graphqelmRequest
        |> toRequest
        |> Http.send (convertResult >> resultToMessage)


toRequest : Request decodesTo -> Http.Request (SuccessOrError decodesTo)
toRequest (Request request) =
    (case request.details of
        Query querySelectionSet ->
            let
                queryRequestDetails =
                    QueryHelper.build Nothing request.baseUrl [] querySelectionSet
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
            , url = request.baseUrl
            , body =
                Http.jsonBody
                    (Json.Encode.object
                        [ ( "query"
                          , Json.Encode.string (Document.serializeMutation mutationSelectionSet)
                          )
                        ]
                    )
            , expect = Http.expectJson (decoderOrError request.expect)
            , timeout = request.timeout
            , withCredentials = request.withCredentials
            }
    )
        |> Http.request


{-| Convert a Request to a Task. See `Graphqelm.Http.send` for an example of
how to build up a Request.
-}
toTask : Request decodesTo -> Task Error decodesTo
toTask request =
    request
        |> toRequest
        |> Http.toTask
        |> Task.mapError HttpError
        |> Task.andThen failTaskOnHttpSuccessWithErrors


failTaskOnHttpSuccessWithErrors : SuccessOrError decodesTo -> Task Error decodesTo
failTaskOnHttpSuccessWithErrors successOrError =
    case successOrError of
        Success value ->
            Task.succeed value

        ErrorThing graphqlErrorGraphqlErrorList ->
            Task.fail (GraphqlError graphqlErrorGraphqlErrorList)


decoderOrError : Json.Decode.Decoder a -> Json.Decode.Decoder (SuccessOrError a)
decoderOrError decoder =
    Json.Decode.oneOf
        [ decoder |> Json.Decode.map Success
        , GraphqlError.decoder |> Json.Decode.map ErrorThing
        ]


{-| Add a header.

    makeRequest : Cmd Msg
    makeRequest =
        query
            |> Graphqelm.Http.queryRequest "https://api.github.com/graphql"
            |> Graphqelm.Http.withHeader "authorization" "Bearer <my token>"
            |> Graphqelm.Http.send (RemoteData.fromResult >> GotResponse)

-}
withHeader : String -> String -> Request decodesTo -> Request decodesTo
withHeader key value (Request request) =
    Request { request | headers = Http.header key value :: request.headers }


{-| Add a timeout.
-}
withTimeout : Time -> Request decodesTo -> Request decodesTo
withTimeout timeout (Request request) =
    Request { request | timeout = Just timeout }


{-| Set with credentials to true.
-}
withCredentials : Request decodesTo -> Request decodesTo
withCredentials (Request request) =
    Request { request | withCredentials = True }
