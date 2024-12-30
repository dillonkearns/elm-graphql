module Graphql.Generator.Let exposing (LetBinding, generate)

import String.Interpolate exposing (interpolate)


type alias LetBinding =
    ( String, String )


generate : List LetBinding -> String
generate letBindings =
    let
        toLetString ( name, value ) =
            interpolate
                """        {0} =
            {1}"""
                [ name, value ]
    in
    if List.isEmpty letBindings then
        ""

    else
        interpolate
            """
    let
{0}
    in"""
            [ letBindings
                |> List.map toLetString
                |> String.join "\n\n"
            ]
