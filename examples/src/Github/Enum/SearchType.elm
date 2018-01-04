module Github.Enum.SearchType exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| Represents the individual results of a search.

  - ISSUE - Returns results matching issues in repositories.
  - REPOSITORY - Returns results matching repositories.
  - USER - Returns results matching users and organizations on GitHub.

-}
type SearchType
    = ISSUE
    | REPOSITORY
    | USER


decoder : Decoder SearchType
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "ISSUE" ->
                        Decode.succeed ISSUE

                    "REPOSITORY" ->
                        Decode.succeed REPOSITORY

                    "USER" ->
                        Decode.succeed USER

                    _ ->
                        Decode.fail ("Invalid SearchType type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : SearchType -> String
toString enum =
    case enum of
        ISSUE ->
            "ISSUE"

        REPOSITORY ->
            "REPOSITORY"

        USER ->
            "USER"
