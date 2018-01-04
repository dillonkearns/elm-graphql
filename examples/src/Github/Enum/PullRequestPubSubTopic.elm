module Github.Enum.PullRequestPubSubTopic exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The possible PubSub channels for a pull request.

  - UPDATED - The channel ID for observing pull request updates.
  - MARKASREAD - The channel ID for marking an pull request as read.
  - HEAD_REF - The channel ID for observing head ref updates.

-}
type PullRequestPubSubTopic
    = UPDATED
    | MARKASREAD
    | HEAD_REF


decoder : Decoder PullRequestPubSubTopic
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "UPDATED" ->
                        Decode.succeed UPDATED

                    "MARKASREAD" ->
                        Decode.succeed MARKASREAD

                    "HEAD_REF" ->
                        Decode.succeed HEAD_REF

                    _ ->
                        Decode.fail ("Invalid PullRequestPubSubTopic type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : PullRequestPubSubTopic -> String
toString enum =
    case enum of
        UPDATED ->
            "UPDATED"

        MARKASREAD ->
            "MARKASREAD"

        HEAD_REF ->
            "HEAD_REF"
