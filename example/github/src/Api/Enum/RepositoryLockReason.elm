module Api.Enum.RepositoryLockReason exposing (..)

import Json.Decode as Decode exposing (Decoder)


type RepositoryLockReason
    = MOVING
    | BILLING
    | RENAME
    | MIGRATING


decoder : Decoder RepositoryLockReason
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "MOVING" ->
                        Decode.succeed MOVING

                    "BILLING" ->
                        Decode.succeed BILLING

                    "RENAME" ->
                        Decode.succeed RENAME

                    "MIGRATING" ->
                        Decode.succeed MIGRATING

                    _ ->
                        Decode.fail ("Invalid RepositoryLockReason type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
