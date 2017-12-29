module Github.Enum.TopicSuggestionDeclineReason exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| Reason that the suggested topic is declined.

  - NOT_RELEVANT - The suggested topic is not relevant to the repository.
  - TOO_SPECIFIC - The suggested topic is too specific for the repository (e.g. #ruby-on-rails-version-4-2-1).
  - PERSONAL_PREFERENCE - The viewer does not like the suggested topic.
  - TOO_GENERAL - The suggested topic is too general for the repository.

-}
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
