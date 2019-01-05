module ModuleName exposing (ModuleName, fromList, toString)


type ModuleName
    = ModuleName (List String)


fromList : List String -> ModuleName
fromList =
    ModuleName


toString : ModuleName -> String
toString (ModuleName moduleNameParts) =
    moduleNameParts
        |> String.join "."
