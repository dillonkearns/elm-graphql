module Github.Enum.IssueState exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The possible states of an issue.

  - Open - An issue that is still open
  - Closed - An issue that has been closed

-}
type IssueState
    = Open
    | Closed


decoder : Decoder IssueState
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "OPEN" ->
                        Decode.succeed Open

                    "CLOSED" ->
                        Decode.succeed Closed

                    _ ->
                        Decode.fail ("Invalid IssueState type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : IssueState -> String
toString enum =
    case enum of
        Open ->
            "OPEN"

        Closed ->
            "CLOSED"
