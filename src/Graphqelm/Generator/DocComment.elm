module Graphqelm.Generator.DocComment exposing (generate, generateForEnum)

import Graphqelm.Parser.CamelCaseName as CamelCaseName
import Graphqelm.Parser.ClassCaseName as ClassCaseName
import Graphqelm.Parser.Type as Type exposing (EnumValue, Field)
import String.Interpolate exposing (interpolate)


hasDocs : Maybe String -> List { item | name : String, description : Maybe String } -> Bool
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
    generate_ description (args |> List.map (\arg -> { arg | name = arg.name |> CamelCaseName.normalized }))


generate_ : Maybe String -> List { item | name : String, description : Maybe String } -> String
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
    generate_ description (enumValues |> List.map (\enumValue -> { enumValue | name = enumValue.name |> ClassCaseName.normalized }))


argsDoc : List { item | name : String, description : Maybe String } -> String
argsDoc args =
    case List.filterMap argDoc args of
        [] ->
            ""

        argDocs ->
            interpolate "\n\n{0}\n" [ argDocs |> String.join "\n" ]


argDoc : { item | name : String, description : Maybe String } -> Maybe String
argDoc { name, description } =
    Maybe.map
        (\aDescription ->
            interpolate "  - {0} - {1}" [ name, aDescription ]
        )
        description
