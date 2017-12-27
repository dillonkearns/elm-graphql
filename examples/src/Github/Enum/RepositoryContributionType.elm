module Github.Enum.RepositoryContributionType exposing (..)

import Json.Decode as Decode exposing (Decoder)


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
