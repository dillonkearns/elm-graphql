module Graphqelm.Generator.Normalize exposing (fieldName, moduleName)


fieldName : String -> String
fieldName name =
    if name == "type" then
        "type_"
    else
        name


moduleName : String -> String
moduleName name =
    if name |> String.startsWith "_" then
        name
            |> String.dropLeft 1
            |> (\nameWithoutLeading_ -> nameWithoutLeading_ ++ "_")
    else
        name
