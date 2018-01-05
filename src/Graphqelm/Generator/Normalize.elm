module Graphqelm.Generator.Normalize exposing (capitalized, decapitalized)

import String.Extra


normalizeIfElmReserved : String -> String
normalizeIfElmReserved name =
    if name == "type" then
        "type_"
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


decapitalized : String -> String
decapitalized name =
    if name |> String.startsWith "_" then
        name
            |> String.dropLeft 1
            |> (\nameWithoutLeading_ -> nameWithoutLeading_ ++ "_")
            |> decapitalized
    else
        name |> String.Extra.decapitalize |> normalizeIfElmReserved
