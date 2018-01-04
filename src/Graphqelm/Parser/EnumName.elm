module Graphqelm.Parser.EnumName exposing (EnumName, enumName, normalized, raw)

import Graphqelm.Generator.Normalize as Normalize


enumName : String -> EnumName
enumName =
    EnumName


type EnumName
    = EnumName String


raw : EnumName -> String
raw (EnumName name) =
    name


normalized : EnumName -> String
normalized (EnumName name) =
    name |> Normalize.capitalized
