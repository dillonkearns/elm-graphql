module Graphqelm.Generator.Normalize exposing (capitalized, decapitalized)

import Char
import Regex
import String.Extra


normalizeIfElmReserved : String -> String
normalizeIfElmReserved name =
    if name == "type" then
        "type_"
    else
        name


underscores : String -> { leading : String, trailing : String, remaining : String }
underscores string =
    case Regex.find Regex.All (Regex.regex "^(_*)([^_]?.*[^_]?)(_*)$") string |> List.head |> Maybe.map .submatches of
        Just [ Just leading, Just remaining, Just trailing ] ->
            { leading = leading
            , trailing = trailing
            , remaining = remaining
            }

        Nothing ->
            Debug.crash "Got nothing"

        _ ->
            Debug.crash ("Unexpected regex result for name " ++ string)


isAllUpper : String -> Bool
isAllUpper string =
    String.toUpper string == string


capitilize : String -> String
capitilize string =
    case string |> String.toList of
        firstChar :: rest ->
            (Char.toUpper firstChar :: rest)
                |> String.fromList

        [] ->
            ""


capitalized : String -> String
capitalized name =
    let
        group =
            underscores name
    in
    (if isAllUpper group.remaining then
        group.remaining
            |> String.toLower
            |> String.Extra.classify
     else
        group.remaining
            |> capitilize
    )
        ++ group.leading
        ++ group.trailing


decapitalized : String -> String
decapitalized name =
    name
        |> capitalized
        |> String.Extra.decapitalize
        |> normalizeIfElmReserved
