module Github.Enum.PullRequestPubSubTopic exposing (..)

import Json.Decode as Decode exposing (Decoder)


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
