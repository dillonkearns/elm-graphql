module Graphqelm.Generator.Enum exposing (..)

import Graphqelm.Parser.Type exposing (EnumValue)
import Interpolate exposing (interpolate)


generate : List String -> String -> List EnumValue -> ( List String, String )
generate apiSubmodule enumName enumValues =
    ( moduleNameFor apiSubmodule enumName
    , prepend apiSubmodule enumName enumValues
    )


moduleNameFor : List String -> String -> List String
moduleNameFor apiSubmodule name =
    apiSubmodule ++ [ "Enum", name ]


prepend : List String -> String -> List EnumValue -> String
prepend apiSubmodule enumName enumValues =
    interpolate """module {0} exposing (..)

import Json.Decode as Decode exposing (Decoder)


"""
        [ moduleNameFor apiSubmodule enumName |> String.join "." ]
        ++ enumType enumName enumValues
        ++ enumDecoder enumName enumValues


enumType : String -> List EnumValue -> String
enumType enumName enumValues =
    "type " ++ enumName ++ """
    = """ ++ (enumValues |> List.map .name |> String.join "\n    | ") ++ "\n"


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
        [ enumName ]
        ++ (enumValues |> List.map .name |> List.map (\enumValue -> "                    \"" ++ enumValue ++ "\" ->\n                        Decode.succeed " ++ enumValue) |> String.join "\n\n")
        ++ """

                    _ ->
                        Decode.fail ("Invalid """
        ++ enumName
        ++ """ type, " ++ string ++ " try re-running the graphqelm CLI ")
        )
        """
