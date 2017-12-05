module Api.Enum.IssuePubSubTopic exposing (..)

import Json.Decode as Decode exposing (Decoder)


type IssuePubSubTopic
    = UPDATED
    | MARKASREAD


decoder : Decoder IssuePubSubTopic
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "UPDATED" ->
                        Decode.succeed UPDATED

                    "MARKASREAD" ->
                        Decode.succeed MARKASREAD

                    _ ->
                        Decode.fail ("Invalid IssuePubSubTopic type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
