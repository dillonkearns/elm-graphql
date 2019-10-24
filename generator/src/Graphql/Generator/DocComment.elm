module Graphql.Generator.DocComment exposing (generate, generateForEnum)

import Graphql.Parser.CamelCaseName as CamelCaseName
import Graphql.Parser.ClassCaseName as ClassCaseName
import Graphql.Parser.Type as Type exposing (EnumValue, Field)
import Result.Extra
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


generate : Field -> Result String String
generate { description, args } =
    args
        |> List.map
            (\arg ->
                arg.name
                    |> CamelCaseName.normalized
                    |> Result.map
                        (\name ->
                            { name = name
                            , description = arg.description
                            }
                        )
            )
        |> Result.Extra.combine
        |> Result.map
            (generate_ description)


generate_ : Maybe String -> List ItemDescription -> String
generate_ mainDescription itemDescriptions =
    if hasDocs mainDescription itemDescriptions then
        interpolate """{-|{0}{1}
-}
"""
            [ mainDescription |> Maybe.map (\description -> " " ++ description) |> Maybe.withDefault "", argsDoc itemDescriptions ]

    else
        ""


generateForEnum : Maybe String -> List EnumValue -> Result String String
generateForEnum description =
    List.map
        (\enumValue ->
            enumValue.name
                |> ClassCaseName.normalized
                |> Result.map
                    (\name ->
                        { name = name
                        , description = enumValue.description
                        }
                    )
        )
        >> Result.Extra.combine
        >> Result.map
            (generate_ description)


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
