module Github.Enum.RepositoryLockReason exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The possible reasons a given repository could be in a locked state.

  - MOVING - The repository is locked due to a move.
  - BILLING - The repository is locked due to a billing related reason.
  - RENAME - The repository is locked due to a rename.
  - MIGRATING - The repository is locked due to a migration.

-}
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


toString : RepositoryLockReason -> String
toString enum =
    case enum of
        MOVING ->
            "MOVING"

        BILLING ->
            "BILLING"

        RENAME ->
            "RENAME"

        MIGRATING ->
            "MIGRATING"
