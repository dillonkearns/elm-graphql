module Github.Enum.CollaboratorAffiliation exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| Collaborators affiliation level with a repository.

  - OUTSIDE - All outside collaborators of an organization-owned repository.
  - DIRECT - All collaborators with permissions to an organization-owned repository, regardless of organization membership status.
  - ALL - All collaborators the authenticated user can see.

-}
type CollaboratorAffiliation
    = OUTSIDE
    | DIRECT
    | ALL


decoder : Decoder CollaboratorAffiliation
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "OUTSIDE" ->
                        Decode.succeed OUTSIDE

                    "DIRECT" ->
                        Decode.succeed DIRECT

                    "ALL" ->
                        Decode.succeed ALL

                    _ ->
                        Decode.fail ("Invalid CollaboratorAffiliation type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
