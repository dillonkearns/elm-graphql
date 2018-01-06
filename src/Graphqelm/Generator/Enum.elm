module Graphqelm.Generator.Enum exposing (enumType, generate)

import Graphqelm.Generator.DocComment as DocComment
import Graphqelm.Generator.Normalize as Normalize
import Graphqelm.Parser.ClassCaseName as ClassCaseName
import Graphqelm.Parser.Type exposing (EnumValue)
import Interpolate exposing (interpolate)


generate : String -> List String -> List EnumValue -> Maybe String -> String
generate enumName moduleName enumValues description =
    prepend moduleName enumName enumValues (enumDocs description enumValues)


enumDocs : Maybe String -> List EnumValue -> String
enumDocs enumDescription enumValues =
    DocComment.generateForEnum enumDescription enumValues


prepend : List String -> String -> List EnumValue -> String -> String
prepend moduleName enumName enumValues docComment =
    interpolate """module {0} exposing (..)

import Json.Decode as Decode exposing (Decoder)


"""
        [ moduleName |> String.join "." ]
        ++ docComment
        ++ enumType enumName enumValues
        ++ enumDecoder enumName enumValues
        ++ "\n\n"
        ++ enumToString enumName enumValues


enumType : String -> List EnumValue -> String
enumType enumName enumValues =
    "type "
        ++ Normalize.capitalized enumName
        ++ """
    = """
        ++ (enumValues
                |> List.map .name
                |> List.map ClassCaseName.normalized
                |> String.join "\n    | "
           )
        ++ "\n"


enumToString : String -> List EnumValue -> String
enumToString enumName enumValues =
    interpolate
        """{-| Convert from the union type representating the Enum to a string that the GraphQL server will recognize.
-}
toString : {0} -> String
toString enum =
    case enum of
{1}"""
        [ Normalize.capitalized enumName
        , List.map toStringCase enumValues |> String.join "\n\n"
        ]


toStringCase : EnumValue -> String
toStringCase enumValue =
    interpolate
        """        {0} ->
                "{1}"
"""
        [ enumValue.name |> ClassCaseName.normalized
        , enumValue.name |> ClassCaseName.raw
        ]


enumDecoder : String -> List EnumValue -> String
enumDecoder enumName enumValues =
    interpolate
        """decoder : Decoder {0}
decoder =
    Decode.string
        |> Decode.andThen
            (\\string ->
                case string of
"""
        [ Normalize.capitalized enumName ]
        ++ (enumValues
                |> List.map .name
                |> List.map
                    (\enumValue ->
                        "                    \""
                            ++ ClassCaseName.raw enumValue
                            ++ "\" ->\n                        Decode.succeed "
                            ++ ClassCaseName.normalized enumValue
                    )
                |> String.join "\n\n"
           )
        ++ """

                    _ ->
                        Decode.fail ("Invalid """
        ++ Normalize.capitalized enumName
        ++ """ type, " ++ string ++ " try re-running the graphqelm CLI ")
        )
        """
