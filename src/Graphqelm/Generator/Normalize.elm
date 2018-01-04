module Graphqelm.Generator.Normalize exposing (capitalized, fieldName, moduleName)

import String.Extra


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


capitalized : String -> String
capitalized name =
    if name |> String.startsWith "_" then
        name
            |> String.dropLeft 1
            |> (\nameWithoutLeading_ -> nameWithoutLeading_ ++ "_")
            |> capitalized
    else
        name |> String.Extra.toSentenceCase
