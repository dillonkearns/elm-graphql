module Github.Enum.ProjectState exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| State of the project; either 'open' or 'closed'

  - OPEN - The project is open.
  - CLOSED - The project is closed.

-}
type ProjectState
    = OPEN
    | CLOSED


decoder : Decoder ProjectState
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
                        Decode.fail ("Invalid ProjectState type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
