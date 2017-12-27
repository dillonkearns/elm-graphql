module Github.Enum.MilestoneState exposing (..)

import Json.Decode as Decode exposing (Decoder)


type MilestoneState
    = OPEN
    | CLOSED


decoder : Decoder MilestoneState
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
                        Decode.fail ("Invalid MilestoneState type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
