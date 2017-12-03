module GraphqElm.Generator.Enum exposing (..)

import Interpolate exposing (interpolate)


generate : String -> List String -> ( List String, String )
generate enumName enumValues =
    ( moduleNameFor enumName
    , prepend enumName enumValues
    )


moduleNameFor : String -> List String
moduleNameFor name =
    [ "Api", "Enum", name ]


prepend : String -> List String -> String
prepend enumName enumValues =
    interpolate """module {0} exposing (..)

import Json.Decode as Decode exposing (Decoder)


"""
        [ moduleNameFor enumName |> String.join "." ]
        ++ enumType enumName enumValues
        ++ enumDecoder enumName enumValues


enumType : String -> List String -> String
enumType enumName enumValues =
    "type " ++ enumName ++ """
    = """ ++ (enumValues |> String.join "\n    | ") ++ "\n"


enumDecoder : String -> List String -> String
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
        ++ (enumValues |> List.map (\enumValue -> "                    \"" ++ enumValue ++ "\" ->\n                        Decode.succeed " ++ enumValue) |> String.join "\n\n")
        ++ """

                    _ ->
                        Decode.fail ("Invalid """
        ++ enumName
        ++ """ type, " ++ string ++ " try re-running the graphqelm CLI ")
        )
        """
