module Graphql.Parser.ClassCaseName exposing (ClassCaseName, build, isBuiltIn, normalized, raw)

import Graphql.Generator.Normalize as Normalize


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
    String.startsWith "__" rawName
