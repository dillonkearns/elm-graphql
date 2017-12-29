module Github.Enum.IssueState exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The possible states of an issue.

  - OPEN - An issue that is still open
  - CLOSED - An issue that has been closed

-}
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
