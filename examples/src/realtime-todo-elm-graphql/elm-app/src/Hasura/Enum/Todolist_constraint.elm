-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Hasura.Enum.Todolist_constraint exposing (Todolist_constraint(..), decoder, fromString, list, toString)

import Json.Decode as Decode exposing (Decoder)


{-| unique or primary key constraints on table "todolist"

  - Todolist\_pkey - unique or primary key constraint

-}
type Todolist_constraint
    = Todolist_pkey


list : List Todolist_constraint
list =
    [ Todolist_pkey ]


decoder : Decoder Todolist_constraint
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "todolist_pkey" ->
                        Decode.succeed Todolist_pkey

                    _ ->
                        Decode.fail ("Invalid Todolist_constraint type, " ++ string ++ " try re-running the @dillonkearns/elm-graphql CLI ")
            )


{-| Convert from the union type representating the Enum to a string that the GraphQL server will recognize.
-}
toString : Todolist_constraint -> String
toString enum =
    case enum of
        Todolist_pkey ->
            "todolist_pkey"


{-| Convert from a String representation to an elm representation enum.
This is the inverse of the Enum `toString` function. So you can call `toString` and then convert back `fromString` safely.

    Swapi.Enum.Episode.NewHope
        |> Swapi.Enum.Episode.toString
        |> Swapi.Enum.Episode.fromString
        == Just NewHope

This can be useful for generating Strings to use for <select> menus to check which item was selected.

-}
fromString : String -> Maybe Todolist_constraint
fromString enumString =
    case enumString of
        "todolist_pkey" ->
            Just Todolist_pkey

        _ ->
            Nothing