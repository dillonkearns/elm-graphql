module Graphql.Generator.Enum exposing (enumType, generate)

import Graphql.Generator.DocComment as DocComment
import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphql.Parser.Type exposing (EnumValue)
import Result.Extra
import String.Interpolate exposing (interpolate)


generate : ClassCaseName -> List String -> List EnumValue -> Maybe String -> Result String String
generate enumName moduleName enumValues description =
    enumValues
        |> enumDocs description
        |> Result.andThen
            (prepend moduleName enumName enumValues)


enumDocs : Maybe String -> List EnumValue -> Result String String
enumDocs enumDescription enumValues =
    DocComment.generateForEnum enumDescription enumValues


prepend : List String -> ClassCaseName -> List EnumValue -> String -> Result String String
prepend moduleName enumName enumValues docComment =
    [ interpolate """module {0} exposing (..)

import Json.Decode as Decode exposing (Decoder)


"""
        [ moduleName |> String.join "." ]
        |> Ok
    , docComment
        |> Ok
    , enumType enumName enumValues
    , enumList enumName enumValues
    , enumDecoder enumName enumValues
    , "\n\n"
        |> Ok
    , enumToString enumName enumValues
    , "\n\n"
        |> Ok
    , enumFromString enumName enumValues
    ]
        |> Result.Extra.combine
        |> Result.map String.concat


enumType : ClassCaseName -> List EnumValue -> Result String String
enumType enumName enumValues =
    Result.map2
        (\name names ->
            "type "
                ++ name
                ++ """
    = """
                ++ (names
                        |> String.join "\n    | "
                   )
                ++ "\n"
        )
        (ClassCaseName.normalized enumName)
        (enumValues
            |> List.map .name
            |> List.map ClassCaseName.normalized
            |> Result.Extra.combine
        )


enumList : ClassCaseName -> List EnumValue -> Result String String
enumList enumName enumValues =
    Result.map2
        (\name names ->
            interpolate """list : List {0}
list =
    [{1}]
"""
                [ name
                , names
                    |> String.join ", "
                ]
        )
        (ClassCaseName.normalized enumName)
        (enumValues
            |> List.map .name
            |> List.map ClassCaseName.normalized
            |> Result.Extra.combine
        )


enumToString : ClassCaseName -> List EnumValue -> Result String String
enumToString enumName enumValues =
    Result.map2
        (\name names ->
            interpolate
                """{-| Convert from the union type representating the Enum to a string that the GraphQL server will recognize.
-}
toString : {0} -> String
toString enum =
    case enum of
{1}"""
                [ name
                , names |> String.join "\n\n"
                ]
        )
        (ClassCaseName.normalized enumName)
        (enumValues
            |> List.map toStringCase
            |> Result.Extra.combine
        )


enumFromString : ClassCaseName -> List EnumValue -> Result String String
enumFromString enumName enumValues =
    Result.map2
        (\name names ->
            interpolate
                """{-| Convert from a String representation to an elm representation enum.
This is the inverse of the Enum `toString` function. So you can call `toString` and then convert back `fromString` safely.

    Swapi.Enum.Episode.NewHope
        |> Swapi.Enum.Episode.toString
        |> Swapi.Enum.Episode.fromString
        == Just NewHope

This can be useful for generating Strings to use for <select> menus to check which item was selected.

-}
fromString : String -> Maybe {0}
fromString enumString =
    case enumString of
{1}
        _ ->
                Nothing
"""
                [ name
                , names |> String.join "\n\n"
                ]
        )
        (ClassCaseName.normalized enumName)
        (enumValues
            |> List.map fromStringCase
            |> Result.Extra.combine
        )


fromStringCase : EnumValue -> Result String String
fromStringCase enumValue =
    enumValue.name
        |> ClassCaseName.normalized
        |> Result.map
            (\normalized ->
                interpolate
                    """        "{0}" ->
                Just {1}
"""
                    [ enumValue.name |> ClassCaseName.raw
                    , normalized
                    ]
            )


toStringCase : EnumValue -> Result String String
toStringCase enumValue =
    enumValue.name
        |> ClassCaseName.normalized
        |> Result.map
            (\normalized ->
                interpolate
                    """        {0} ->
                "{1}"
"""
                    [ normalized
                    , enumValue.name |> ClassCaseName.raw
                    ]
            )


enumDecoder : ClassCaseName -> List EnumValue -> Result String String
enumDecoder enumName enumValues =
    Result.map2
        (\name names ->
            interpolate
                """decoder : Decoder {0}
decoder =
    Decode.string
        |> Decode.andThen
            (\\string ->
                case string of
"""
                [ name ]
                ++ (names
                        |> String.join "\n\n"
                   )
                ++ """

                    _ ->
                        Decode.fail ("Invalid """
                ++ name
                ++ """ type, " ++ string ++ " try re-running the @dillonkearns/elm-graphql CLI ")
        )
        """
        )
        (ClassCaseName.normalized enumName)
        (enumValues
            |> List.map
                (\enumValue ->
                    enumValue.name
                        |> ClassCaseName.normalized
                        |> Result.map
                            (\res ->
                                "                    \""
                                    ++ ClassCaseName.raw enumValue.name
                                    ++ "\" ->\n                        Decode.succeed "
                                    ++ res
                            )
                )
            |> Result.Extra.combine
        )
