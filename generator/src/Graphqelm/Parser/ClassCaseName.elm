module Graphqelm.Parser.ClassCaseName exposing (ClassCaseName, build, isBuiltIn, normalized, raw)

import Graphqelm.Generator.Normalize as Normalize


build : String -> ClassCaseName
build =
    ClassCaseName


type ClassCaseName
    = ClassCaseName String


raw : ClassCaseName -> String
raw (ClassCaseName rawName) =
    rawName


normalized : ClassCaseName -> String
normalized (ClassCaseName rawName) =
    rawName |> Normalize.capitalized


isBuiltIn : ClassCaseName -> Bool
isBuiltIn (ClassCaseName rawName) =
    if String.startsWith "__" rawName then
        True

    else
        False
