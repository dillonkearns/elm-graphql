module Graphqelm.Generator.DocComment exposing (generate)

import Graphqelm.Parser.Type as Type exposing (Field, ReferrableType, TypeReference)
import Interpolate exposing (interpolate)


hasDocs : Field -> Bool
hasDocs { description, args } =
    case description of
        Just string ->
            True

        Nothing ->
            List.filterMap .description args
                |> List.isEmpty
                |> not


generate : Field -> String
generate ({ description, args } as field) =
    if hasDocs field then
        interpolate """{-|{0}{1}
-}
"""
            [ description |> Maybe.map (\description -> " " ++ description) |> Maybe.withDefault "", argsDoc args ]
    else
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
