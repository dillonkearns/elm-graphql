module Github.Enum.RepositoryContributionType exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The reason a repository is listed as 'contributed'.

  - COMMIT - Created a commit
  - ISSUE - Created an issue
  - PULL_REQUEST - Created a pull request
  - REPOSITORY - Created the repository
  - PULL_REQUEST_REVIEW - Reviewed a pull request

-}
type RepositoryContributionType
    = COMMIT
    | ISSUE
    | PULL_REQUEST
    | REPOSITORY
    | PULL_REQUEST_REVIEW


decoder : Decoder RepositoryContributionType
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "COMMIT" ->
                        Decode.succeed COMMIT

                    "ISSUE" ->
                        Decode.succeed ISSUE

                    "PULL_REQUEST" ->
                        Decode.succeed PULL_REQUEST

                    "REPOSITORY" ->
                        Decode.succeed REPOSITORY

                    "PULL_REQUEST_REVIEW" ->
                        Decode.succeed PULL_REQUEST_REVIEW

                    _ ->
                        Decode.fail ("Invalid RepositoryContributionType type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : RepositoryContributionType -> String
toString enum =
    case enum of
        COMMIT ->
            "COMMIT"

        ISSUE ->
            "ISSUE"

        PULL_REQUEST ->
            "PULL_REQUEST"

        REPOSITORY ->
            "REPOSITORY"

        PULL_REQUEST_REVIEW ->
            "PULL_REQUEST_REVIEW"
