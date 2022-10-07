module ModuleName exposing (ModuleName, append, fromList, toAnnotation, toString)

import Elm.Annotation


type ModuleName
    = ModuleName (List String)


fromList : List String -> ModuleName
fromList =
    ModuleName


toAnnotation : String -> ModuleName -> Elm.Annotation.Annotation
toAnnotation string (ModuleName moduleNameParts) =
    Elm.Annotation.named moduleNameParts string


toString : ModuleName -> String
toString (ModuleName moduleNameParts) =
    moduleNameParts
        |> String.join "."


append : String -> ModuleName -> String
append string (ModuleName moduleNameParts) =
    moduleNameParts
        ++ [ string ]
        |> String.join "."
