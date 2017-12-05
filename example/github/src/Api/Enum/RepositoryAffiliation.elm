module Api.Enum.RepositoryAffiliation exposing (..)

import Json.Decode as Decode exposing (Decoder)


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
