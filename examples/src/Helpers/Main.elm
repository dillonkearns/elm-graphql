module Helpers.Main exposing (view)

import Browser
import Html exposing (div, h1, p, pre, text)
import PrintAny


view : String -> a -> Browser.Document msg
view query model =
    { title = "Query Explorer"
    , body =
        [ div []
            [ div []
                [ h1 [] [ text "Generated Query" ]
                , pre [] [ text query ]
                ]
            , div []
                [ h1 [] [ text "Response" ]
                , model |> PrintAny.view
                ]
            ]
        ]
    }
