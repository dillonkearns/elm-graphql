module GraphqElm.Generator.Enum exposing (..)

import String.Format


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
    String.Format.format1 """module {1} exposing (..)


"""
        (moduleNameFor enumName |> String.join ".")
        ++ enumType enumName enumValues


enumType : String -> List String -> String
enumType enumName enumValues =
    "type " ++ enumName ++ """
    = """ ++ (enumValues |> String.join "\n    | ") ++ "\n"
