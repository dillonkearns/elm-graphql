module Graphqelm.Generator.DocComment exposing (generate)

import Graphqelm.Parser.Type as Type exposing (Field, ReferrableType, TypeReference)
import Interpolate exposing (interpolate)


generate : Field -> String
generate { description, args } =
    case description of
        Just actualDescription ->
            interpolate """{-| {0}{1}
-}
"""
                [ actualDescription, argsDoc args ]

        Nothing ->
            ""


argsDoc : List Type.Arg -> String
argsDoc args =
    case List.filterMap argDoc args of
        [] ->
            ""

        argDocs ->
            interpolate "\n\n{0}\n" [ argDocs |> String.join "\n" ]


argDoc : Type.Arg -> Maybe String
argDoc { name, description } =
    Maybe.map
        (\aDescription ->
            interpolate "  - {0} - {1}" [ name, aDescription ]
        )
        description
