module ElmPackage exposing (request)

import Http
import Json.Decode as Decode exposing (Decoder)


request : Cmd (Result Http.Error (List String))
request =
    Http.get
        { url = "https://package.elm-lang.org/search.json"
        , expect = Http.expectJson identity decoder
        }



-- Http.riskyRequest
--     { method = "GET"
--     , headers = []
--     , url = "https://package.elm-lang.org/search.json"
--     , body = Http.emptyBody
--     , expect = Http.expectJson identity decoder
--     , timeout = Nothing
--     , tracker = Nothing
--     }


decoder : Decoder (List String)
decoder =
    Decode.list (Decode.field "name" Decode.string)
