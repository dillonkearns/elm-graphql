module Github.Enum.TopicSuggestionDeclineReason exposing (..)

import Json.Decode as Decode exposing (Decoder)


type TopicSuggestionDeclineReason
    = NOT_RELEVANT
    | TOO_SPECIFIC
    | PERSONAL_PREFERENCE
    | TOO_GENERAL


decoder : Decoder TopicSuggestionDeclineReason
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "NOT_RELEVANT" ->
                        Decode.succeed NOT_RELEVANT

                    "TOO_SPECIFIC" ->
                        Decode.succeed TOO_SPECIFIC

                    "PERSONAL_PREFERENCE" ->
                        Decode.succeed PERSONAL_PREFERENCE

                    "TOO_GENERAL" ->
                        Decode.succeed TOO_GENERAL

                    _ ->
                        Decode.fail ("Invalid TopicSuggestionDeclineReason type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
