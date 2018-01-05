module Github.Enum.PullRequestPubSubTopic exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The possible PubSub channels for a pull request.

  - Updated - The channel ID for observing pull request updates.
  - Markasread - The channel ID for marking an pull request as read.
  - HeadRef - The channel ID for observing head ref updates.

-}
type PullRequestPubSubTopic
    = Updated
    | Markasread
    | HeadRef


decoder : Decoder PullRequestPubSubTopic
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "UPDATED" ->
                        Decode.succeed Updated

                    "MARKASREAD" ->
                        Decode.succeed Markasread

                    "HEAD_REF" ->
                        Decode.succeed HeadRef

                    _ ->
                        Decode.fail ("Invalid PullRequestPubSubTopic type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : PullRequestPubSubTopic -> String
toString enum =
    case enum of
        Updated ->
            "UPDATED"

        Markasread ->
            "MARKASREAD"

        HeadRef ->
            "HEAD_REF"
