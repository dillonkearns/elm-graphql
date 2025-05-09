-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Swapi.Enum.Language exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-|

  - No - Norwegian
  - Es - Spanish
  - En - English

-}
type Language
    = No
    | Es
    | En


list : List Language
list =
    [ No, Es, En ]


decoder : Decoder Language
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "NO" ->
                        Decode.succeed No

                    "ES" ->
                        Decode.succeed Es

                    "EN" ->
                        Decode.succeed En

                    _ ->
                        Decode.fail ("Invalid Language type, " ++ string ++ " try re-running the @dillonkearns/elm-graphql CLI ")
            )


{-| Convert from the union type representing the Enum to a string that the GraphQL server will recognize.
-}
toString : Language -> String
toString enum____ =
    case enum____ of
        No ->
            "NO"

        Es ->
            "ES"

        En ->
            "EN"


{-| Convert from a String representation to an elm representation enum.
This is the inverse of the Enum `toString` function. So you can call `toString` and then convert back `fromString` safely.

    Swapi.Enum.Episode.NewHope
        |> Swapi.Enum.Episode.toString
        |> Swapi.Enum.Episode.fromString
        == Just NewHope

This can be useful for generating Strings to use for <select> menus to check which item was selected.

-}
fromString : String -> Maybe Language
fromString enumString____ =
    case enumString____ of
        "NO" ->
            Just No

        "ES" ->
            Just Es

        "EN" ->
            Just En

        _ ->
            Nothing
