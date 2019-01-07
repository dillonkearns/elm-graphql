module ModuleName exposing (ModuleName, append, fromList, toString)


type ModuleName
    = ModuleName (List String)


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
