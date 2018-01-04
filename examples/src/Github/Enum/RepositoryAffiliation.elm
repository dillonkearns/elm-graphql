module Github.Enum.RepositoryAffiliation exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The affiliation of a user to a repository

  - OWNER - Repositories that are owned by the authenticated user.
  - COLLABORATOR - Repositories that the user has been added to as a collaborator.
  - ORGANIZATION_MEMBER - Repositories that the user has access to through being a member of an organization. This includes every repository on every team that the user is on.

-}
type RepositoryAffiliation
    = OWNER
    | COLLABORATOR
    | ORGANIZATION_MEMBER


decoder : Decoder RepositoryAffiliation
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "OWNER" ->
                        Decode.succeed OWNER

                    "COLLABORATOR" ->
                        Decode.succeed COLLABORATOR

                    "ORGANIZATION_MEMBER" ->
                        Decode.succeed ORGANIZATION_MEMBER

                    _ ->
                        Decode.fail ("Invalid RepositoryAffiliation type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : RepositoryAffiliation -> String
toString enum =
    case enum of
        OWNER ->
            "OWNER"

        COLLABORATOR ->
            "COLLABORATOR"

        ORGANIZATION_MEMBER ->
            "ORGANIZATION_MEMBER"
