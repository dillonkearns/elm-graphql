module Api.Enum.IssueState exposing (..)

import Json.Decode as Decode exposing (Decoder)


type IssueState
    = OPEN
    | CLOSED


decoder : Decoder IssueState
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "OPEN" ->
                        Decode.succeed OPEN

                    "CLOSED" ->
                        Decode.succeed CLOSED

                    _ ->
                        Decode.fail ("Invalid IssueState type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
