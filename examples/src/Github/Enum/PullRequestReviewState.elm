module Github.Enum.PullRequestReviewState exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The possible states of a pull request review.

  - PENDING - A review that has not yet been submitted.
  - COMMENTED - An informational review.
  - APPROVED - A review allowing the pull request to merge.
  - CHANGES_REQUESTED - A review blocking the pull request from merging.
  - DISMISSED - A review that has been dismissed.

-}
type PullRequestReviewState
    = PENDING
    | COMMENTED
    | APPROVED
    | CHANGES_REQUESTED
    | DISMISSED


decoder : Decoder PullRequestReviewState
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "PENDING" ->
                        Decode.succeed PENDING

                    "COMMENTED" ->
                        Decode.succeed COMMENTED

                    "APPROVED" ->
                        Decode.succeed APPROVED

                    "CHANGES_REQUESTED" ->
                        Decode.succeed CHANGES_REQUESTED

                    "DISMISSED" ->
                        Decode.succeed DISMISSED

                    _ ->
                        Decode.fail ("Invalid PullRequestReviewState type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
