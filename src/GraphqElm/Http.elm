module GraphqElm.Http exposing (request, send, sendRemoteData, withHeader, withTimeout)

import GraphqElm.Field as Field
import Http
import Json.Encode
import RemoteData exposing (WebData)
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


request : String -> Field.Query decodesTo -> Request decodesTo
request url query =
    { method = "POST"
    , headers = []
    , url = url
    , body = Http.jsonBody (Json.Encode.object [ ( "query", Json.Encode.string (Field.toQuery query) ) ])
    , expect = Http.expectJson (Field.decoder query)
    , timeout = Nothing
    , withCredentials = False
    }
        |> Request


send : (Result Http.Error a -> msg) -> Request a -> Cmd msg
send resultToMessage (Request request) =
    request
        |> Http.request
        |> Http.send resultToMessage


sendRemoteData : (WebData decodesTo -> msg) -> Request decodesTo -> Cmd msg
sendRemoteData resultToMsg (Request request) =
    request
        |> Http.request
        |> RemoteData.sendRequest
        |> Cmd.map resultToMsg


withHeader : String -> String -> Request decodesTo -> Request decodesTo
withHeader key value (Request request) =
    Request { request | headers = Http.header key value :: request.headers }


withTimeout : Time -> Request decodesTo -> Request decodesTo
withTimeout timeout (Request request) =
    Request { request | timeout = Just timeout }


withCredentials : Request decodesTo -> Request decodesTo
withCredentials (Request request) =
    Request { request | withCredentials = True }
