module Graphql.Generator.Normalize exposing (capitalized, decapitalized)

import Char
import MyDebug
import Regex
import String.Extra


normalizeIfElmReserved : String -> String
normalizeIfElmReserved name =
    if List.member name elmReservedWords then
        name ++ "_"

    else
        name


underscores : String -> { leading : String, trailing : String, remaining : Maybe String }
underscores string =
    let
        regexFromString =
            Regex.fromString >> Maybe.withDefault Regex.never
    in
    case Regex.find (regexFromString "^(_*)([^_]?.*[^_]?)(_*)$") string |> List.head |> Maybe.map .submatches of
        Just [ leading, remaining, trailing ] ->
            { leading = Maybe.withDefault "" leading
            , trailing = Maybe.withDefault "" trailing
            , remaining = remaining
            }

        Nothing ->
            MyDebug.crash "Got nothing"

        _ ->
            MyDebug.crash ("Unexpected regex result for name " ++ string)


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
    case group.remaining of
        Nothing ->
            "underscore"
                ++ group.leading
                ++ group.trailing

        Just remaining ->
            (if isAllUpper remaining then
                remaining
                    |> String.toLower
                    |> String.Extra.classify

             else
                remaining
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


{-| Taken from <https://github.com/elm-lang/elm-compiler/blob/d07679322ef5d71de1bd2b987ddc660a85599b87/compiler/src/Parse/Primitives/Variable.hs#L64>
-}
elmReservedWords : List String
elmReservedWords =
    [ "as"
    , "case"
    , "else"
    , "exposing"
    , "if"
    , "import"
    , "in"
    , "infix" -- `infix` is a keyword rather than reserved, but it can't be used as a top-level identifier
    , "let"
    , "module"
    , "of"
    , "port"
    , "then"
    , "type"
    , "where"
    ]
