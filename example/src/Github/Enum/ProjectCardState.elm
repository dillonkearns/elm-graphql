module Github.Enum.ProjectCardState exposing (..)

import Json.Decode as Decode exposing (Decoder)


type ProjectCardState
    = CONTENT_ONLY
    | NOTE_ONLY
    | REDACTED


decoder : Decoder ProjectCardState
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "CONTENT_ONLY" ->
                        Decode.succeed CONTENT_ONLY

                    "NOTE_ONLY" ->
                        Decode.succeed NOTE_ONLY

                    "REDACTED" ->
                        Decode.succeed REDACTED

                    _ ->
                        Decode.fail ("Invalid ProjectCardState type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
