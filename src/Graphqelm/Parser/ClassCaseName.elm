module Graphqelm.Parser.ClassCaseName exposing (ClassCaseName, build, normalized, raw)

import Graphqelm.Generator.Normalize as Normalize


build : String -> ClassCaseName
build =
    ClassCaseName


type ClassCaseName
    = ClassCaseName String


raw : ClassCaseName -> String
raw (ClassCaseName name) =
    name


normalized : ClassCaseName -> String
normalized (ClassCaseName name) =
    name |> Normalize.capitalized
