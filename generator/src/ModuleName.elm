module ModuleName exposing (ModuleName, append, elmiFilenameDecoder, fromList, startsWith, toImport, toString)

import Json.Decode as Decode exposing (Decoder)


type ModuleName
    = ModuleName (List String)


elmiFilenameDecoder : Decoder ModuleName
elmiFilenameDecoder =
    Decode.string
        |> Decode.map (String.split "-")
        |> Decode.map fromList


fromList : List String -> ModuleName
fromList =
    ModuleName


startsWith : String -> ModuleName -> Bool
startsWith firstItem (ModuleName moduleNameParts) =
    List.head moduleNameParts == Just firstItem


toImport : ModuleName -> String
toImport moduleName =
    "import " ++ toString moduleName


toString : ModuleName -> String
toString (ModuleName moduleNameParts) =
    moduleNameParts
        |> String.join "."


append : String -> ModuleName -> String
append string (ModuleName moduleNameParts) =
    moduleNameParts
        ++ [ string ]
        |> String.join "."
