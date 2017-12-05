module Api.Enum.PullRequestReviewState exposing (..)

import Json.Decode as Decode exposing (Decoder)


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
