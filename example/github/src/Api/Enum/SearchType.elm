module Api.Enum.SearchType exposing (..)

import Json.Decode as Decode exposing (Decoder)


type SearchType
    = ISSUE
    | REPOSITORY
    | USER


decoder : Decoder SearchType
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "ISSUE" ->
                        Decode.succeed ISSUE

                    "REPOSITORY" ->
                        Decode.succeed REPOSITORY

                    "USER" ->
                        Decode.succeed USER

                    _ ->
                        Decode.fail ("Invalid SearchType type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
