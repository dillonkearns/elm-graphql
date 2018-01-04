module Graphqelm.Parser.FieldName exposing (FieldName, fieldName, normalized, raw)

import Graphqelm.Generator.Normalize as Normalize


type FieldName
    = FieldName String


fieldName : String -> FieldName
fieldName =
    FieldName


raw : FieldName -> String
raw (FieldName name) =
    name


normalized : FieldName -> String
normalized (FieldName name) =
    name |> Normalize.decapitalized
