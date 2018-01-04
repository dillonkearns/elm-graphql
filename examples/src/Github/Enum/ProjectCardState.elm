module Github.Enum.ProjectCardState exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| Various content states of a ProjectCard

  - CONTENT_ONLY - The card has content only.
  - NOTE_ONLY - The card has a note only.
  - REDACTED - The card is redacted.

-}
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


toString : ProjectCardState -> String
toString enum =
    case enum of
        CONTENT_ONLY ->
            "CONTENT_ONLY"

        NOTE_ONLY ->
            "NOTE_ONLY"

        REDACTED ->
            "REDACTED"
