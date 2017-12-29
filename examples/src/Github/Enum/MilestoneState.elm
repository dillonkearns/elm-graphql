module Github.Enum.MilestoneState exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The possible states of a milestone.

  - OPEN - A milestone that is still open.
  - CLOSED - A milestone that has been closed.

-}
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
