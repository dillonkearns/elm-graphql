module Api.Enum.PullRequestState exposing (..)

import Json.Decode as Decode exposing (Decoder)


type PullRequestState
    = OPEN
    | CLOSED
    | MERGED


decoder : Decoder PullRequestState
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "OPEN" ->
                        Decode.succeed OPEN

                    "CLOSED" ->
                        Decode.succeed CLOSED

                    "MERGED" ->
                        Decode.succeed MERGED

                    _ ->
                        Decode.fail ("Invalid PullRequestState type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
