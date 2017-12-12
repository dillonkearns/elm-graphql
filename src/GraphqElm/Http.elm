module Graphqelm.Http exposing (Request, buildMutationRequest, buildQueryRequest, send, toRequest, withHeader, withTimeout)

{-| Send requests to your GraphQL endpoint. See the `examples/` folder for an end-to-end example.
The builder syntax is inspired by Luke Westby's
[elm-http-builder package](http://package.elm-lang.org/packages/lukewestby/elm-http-builder/latest).

@docs buildQueryRequest, buildMutationRequest, send, toRequest, withHeader, withTimeout
@docs Request

-}

import Graphqelm exposing (RootMutation, RootQuery)
import Graphqelm.Document.LowLevel as Document
import Graphqelm.DocumentSerializer as DocumentSerializer
import Graphqelm.Object exposing (Object)
import Http
import Json.Encode
import Time exposing (Time)


{-| TODO
-}
type Request decodesTo
    = Request
        { method : String
        , headers : List Http.Header
        , url : String
        , body : Http.Body
        , expect : Http.Expect decodesTo
        , timeout : Maybe Time
        , withCredentials : Bool
        }


{-| TODO
-}
buildRequest : String -> String -> Object decodesTo typeLock -> Request decodesTo
buildRequest url queryDocument query =
    { method = "POST"
    , headers = []
    , url = url
    , body = Http.jsonBody (Json.Encode.object [ ( "query", Json.Encode.string queryDocument ) ])
    , expect = Http.expectJson (Document.decoder query)
    , timeout = Nothing
    , withCredentials = False
    }
        |> Request


{-| TODO
-}
buildQueryRequest : String -> Object decodesTo RootQuery -> Request decodesTo
buildQueryRequest url query =
    buildRequest url (DocumentSerializer.serializeQuery query) query


{-| TODO
-}
buildMutationRequest : String -> Object decodesTo RootMutation -> Request decodesTo
buildMutationRequest url query =
    buildRequest url (DocumentSerializer.serializeMutation query) query


{-| Send the `Graphqelm.Request`
-}
send : (Result Http.Error a -> msg) -> Request a -> Cmd msg
send resultToMessage graphqelmRequest =
    graphqelmRequest
        |> toRequest
        |> Http.send resultToMessage


{-| Convert to a `Graphqelm.Http.Request` to an `Http.Request`.
Useful for using libraries like
[RemoteData](http://package.elm-lang.org/packages/krisajenkins/remotedata/latest/).

    makeRequest : Cmd Msg
    makeRequest =
        query
            |> Graphqelm.Http.buildQueryRequest "http://localhost:4000/api"
            |> Graphqelm.Http.toRequest
            |> RemoteData.sendRequest
            |> Cmd.map GotResponse

-}
toRequest : Request decodesTo -> Http.Request decodesTo
toRequest (Request request) =
    request
        |> Http.request


{-| Add a header.
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
