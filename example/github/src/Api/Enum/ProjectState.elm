module Api.Enum.ProjectState exposing (..)

import Json.Decode as Decode exposing (Decoder)


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
