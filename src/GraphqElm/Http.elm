module GraphqElm.Http exposing (..)

import GraphqElm.Field as Field
import Http
import HttpBuilder


request : String -> Field.RootQuery a -> Http.Request a
request url query =
    -- Http.request
    --     { method = "POST"
    --     , headers = []
    --     , url = url
    --     , body = Http.stringBody "text/plain" (Field.toQuery query)
    --
    --     -- , body = Http.stringBody "application/json" (Field.toQuery query)
    --     , expect = Http.expectJson (Field.decoder query)
    --     , timeout = Nothing
    --     , withCredentials = False
    --     }
    HttpBuilder.post "http://localhost:4000/api"
        |> HttpBuilder.withExpect (Http.expectJson (Field.decoder query))
        |> HttpBuilder.withBody
            (Http.stringBody "text/plain"
                (Field.toQuery query)
            )
        -- (Json.Encode.object
        --     [ ( "query", Json.Encode.string (Field.toQuery query) ) ]
        --     |> Json.Encode.encode 0
        -- )
        -- )
        |> HttpBuilder.toRequest
