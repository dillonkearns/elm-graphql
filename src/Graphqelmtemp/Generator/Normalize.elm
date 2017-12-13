module Graphqelm.Generator.Normalize exposing (fieldName)


fieldName : String -> String
fieldName name =
    if name == "type" then
        "type_"
    else
        name
