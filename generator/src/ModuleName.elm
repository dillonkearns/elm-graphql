module ModuleName exposing (ModuleName, append, elmiFilenameDecoder, fromList, toString)

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


toString : ModuleName -> String
toString (ModuleName moduleNameParts) =
    moduleNameParts
        |> String.join "."


append : String -> ModuleName -> String
append string (ModuleName moduleNameParts) =
    moduleNameParts
        ++ [ string ]
        |> String.join "."
