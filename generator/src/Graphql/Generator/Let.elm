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

        letString =
            letBindings
                |> List.map toLetString
                |> String.join "\n\n"
    in
    if letBindings == [] then
        ""

    else
        interpolate
            """
    let
{0}
    in"""
            [ letString ]
