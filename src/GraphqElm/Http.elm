module Graphqelm.Http exposing (buildRequest, request, send, toRequest, withHeader, withTimeout)

import Graphqelm.Query as Query exposing (RootField)
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


request : String -> RootField decodesTo -> Http.Request decodesTo
request url query =
    buildRequest url query
        |> toRequest


buildRequest : String -> RootField decodesTo -> Request decodesTo
buildRequest url query =
    { method = "POST"
    , headers = []
    , url = url
    , body = Http.jsonBody (Json.Encode.object [ ( "query", Json.Encode.string (Query.toQuery query) ) ])
    , expect = Http.expectJson (Query.decoder query)
    , timeout = Nothing
    , withCredentials = False
    }
        |> Request


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
