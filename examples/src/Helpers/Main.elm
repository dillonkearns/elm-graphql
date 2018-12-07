module Helpers.Main exposing (view)

import Browser
import Html exposing (div, h1, p, pre, text)
import PrintAny
import Regex


view : String -> a -> Browser.Document msg
view query model =
    { title = "Query Explorer"
    , body =
        [ div []
            [ div []
                [ h1 [] [ text "Generated Query" ]
                , pre []
                    [ query
                        |> stripAliases
                        |> text
                    ]
                ]
            , div []
                [ h1 [] [ text "Response" ]
                , model |> PrintAny.view
                ]
            ]
        ]
    }


stripAliases query =
    query
        |> Regex.replace
            (Regex.fromStringWith { multiline = True, caseInsensitive = True } "^(\\s*)\\w+: "
                |> Maybe.withDefault Regex.never
            )
            (\match -> match.submatches |> List.head |> Maybe.withDefault Nothing |> Maybe.withDefault "")
