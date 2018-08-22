module Graphql.Generator.DocComment exposing (generate, generateForEnum)

import Graphql.Parser.CamelCaseName as CamelCaseName
import Graphql.Parser.ClassCaseName as ClassCaseName
import Graphql.Parser.Type as Type exposing (EnumValue, Field)
import String.Interpolate exposing (interpolate)


type alias ItemDescription =
    { name : String, description : Maybe String }


hasDocs : Maybe String -> List ItemDescription -> Bool
hasDocs mainDescription itemDescriptions =
    case mainDescription of
        Just string ->
            True

        Nothing ->
            List.filterMap .description itemDescriptions
                |> List.isEmpty
                |> not


generate : Field -> String
generate { description, args } =
    generate_ description (args |> List.map (\arg -> { name = arg.name |> CamelCaseName.normalized, description = arg.description }))


generate_ : Maybe String -> List ItemDescription -> String
generate_ mainDescription itemDescriptions =
    if hasDocs mainDescription itemDescriptions then
        interpolate """{-|{0}{1}
-}
"""
            [ mainDescription |> Maybe.map (\description -> " " ++ description) |> Maybe.withDefault "", argsDoc itemDescriptions ]

    else
        ""


generateForEnum : Maybe String -> List EnumValue -> String
generateForEnum description enumValues =
    generate_ description (enumValues |> List.map (\enumValue -> { name = enumValue.name |> ClassCaseName.normalized, description = enumValue.description }))


argsDoc : List ItemDescription -> String
argsDoc args =
    case List.filterMap argDoc args of
        [] ->
            ""

        argDocs ->
            interpolate "\n\n{0}\n" [ argDocs |> String.join "\n" ]


argDoc : ItemDescription -> Maybe String
argDoc { name, description } =
    Maybe.map
        (\aDescription ->
            interpolate "  - {0} - {1}" [ name, aDescription ]
        )
        description
