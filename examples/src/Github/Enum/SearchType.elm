module Github.Enum.SearchType exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| Represents the individual results of a search.

  - Issue - Returns results matching issues in repositories.
  - Repository - Returns results matching repositories.
  - User - Returns results matching users and organizations on GitHub.

-}
type SearchType
    = Issue
    | Repository
    | User


decoder : Decoder SearchType
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "ISSUE" ->
                        Decode.succeed Issue

                    "REPOSITORY" ->
                        Decode.succeed Repository

                    "USER" ->
                        Decode.succeed User

                    _ ->
                        Decode.fail ("Invalid SearchType type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : SearchType -> String
toString enum =
    case enum of
        Issue ->
            "ISSUE"

        Repository ->
            "REPOSITORY"

        User ->
            "USER"
