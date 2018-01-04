module Github.Enum.MergeableState exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| Whether or not a PullRequest can be merged.

  - MERGEABLE - The pull request can be merged.
  - CONFLICTING - The pull request cannot be merged due to merge conflicts.
  - UNKNOWN - The mergeability of the pull request is still being calculated.

-}
type MergeableState
    = MERGEABLE
    | CONFLICTING
    | UNKNOWN


decoder : Decoder MergeableState
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "MERGEABLE" ->
                        Decode.succeed MERGEABLE

                    "CONFLICTING" ->
                        Decode.succeed CONFLICTING

                    "UNKNOWN" ->
                        Decode.succeed UNKNOWN

                    _ ->
                        Decode.fail ("Invalid MergeableState type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : MergeableState -> String
toString enum =
    case enum of
        MERGEABLE ->
            "MERGEABLE"

        CONFLICTING ->
            "CONFLICTING"

        UNKNOWN ->
            "UNKNOWN"
