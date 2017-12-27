module Github.Enum.PullRequestReviewEvent exposing (..)

import Json.Decode as Decode exposing (Decoder)


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
