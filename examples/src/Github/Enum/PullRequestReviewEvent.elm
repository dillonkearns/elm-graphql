module Github.Enum.PullRequestReviewEvent exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The possible events to perform on a pull request review.

  - COMMENT - Submit general feedback without explicit approval.
  - APPROVE - Submit feedback and approve merging these changes.
  - REQUEST_CHANGES - Submit feedback that must be addressed before merging.
  - DISMISS - Dismiss review so it now longer effects merging.

-}
type PullRequestReviewEvent
    = COMMENT
    | APPROVE
    | REQUEST_CHANGES
    | DISMISS


decoder : Decoder PullRequestReviewEvent
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "COMMENT" ->
                        Decode.succeed COMMENT

                    "APPROVE" ->
                        Decode.succeed APPROVE

                    "REQUEST_CHANGES" ->
                        Decode.succeed REQUEST_CHANGES

                    "DISMISS" ->
                        Decode.succeed DISMISS

                    _ ->
                        Decode.fail ("Invalid PullRequestReviewEvent type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : PullRequestReviewEvent -> String
toString enum =
    case enum of
        COMMENT ->
            "COMMENT"

        APPROVE ->
            "APPROVE"

        REQUEST_CHANGES ->
            "REQUEST_CHANGES"

        DISMISS ->
            "DISMISS"
