module Graphqelm.Http exposing (buildMutationRequest, buildQueryRequest, send, toRequest, withHeader, withTimeout)

import Graphqelm.Document exposing (RootMutation, RootQuery)
import Graphqelm.Document.LowLevel as Document
import Graphqelm.Object exposing (Object)
import Http
import Json.Encode
import Time exposing (Time)


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


buildQueryRequest : String -> Object decodesTo RootQuery -> Request decodesTo
buildQueryRequest url query =
    buildRequest url (Document.toQueryDocument query) query


buildMutationRequest : String -> Object decodesTo RootMutation -> Request decodesTo
buildMutationRequest url query =
    buildRequest url (Document.toMutationDocument query) query


send : (Result Http.Error a -> msg) -> Request a -> Cmd msg
send resultToMessage (Request request) =
    request
        |> Http.request
        |> Http.send resultToMessage


toRequest : Request decodesTo -> Http.Request decodesTo
toRequest (Request request) =
    request
        |> Http.request


withHeader : String -> String -> Request decodesTo -> Request decodesTo
withHeader key value (Request request) =
    Request { request | headers = Http.header key value :: request.headers }


withTimeout : Time -> Request decodesTo -> Request decodesTo
withTimeout timeout (Request request) =
    Request { request | timeout = Just timeout }


withCredentials : Request decodesTo -> Request decodesTo
withCredentials (Request request) =
    Request { request | withCredentials = True }
