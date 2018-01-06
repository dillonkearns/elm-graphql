module Graphqelm.Parser.CamelCaseName exposing (CamelCaseName, build, normalized, raw)

import Graphqelm.Generator.Normalize as Normalize


type CamelCaseName
    = CamelCaseName String


build : String -> CamelCaseName
build =
    CamelCaseName


raw : CamelCaseName -> String
raw (CamelCaseName name) =
    name


normalized : CamelCaseName -> String
normalized (CamelCaseName name) =
    name |> Normalize.decapitalized
