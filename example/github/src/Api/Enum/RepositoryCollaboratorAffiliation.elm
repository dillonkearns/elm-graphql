module Api.Enum.RepositoryCollaboratorAffiliation exposing (..)

import Json.Decode as Decode exposing (Decoder)


type RepositoryCollaboratorAffiliation
    = ALL
    | OUTSIDE


decoder : Decoder RepositoryCollaboratorAffiliation
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "ALL" ->
                        Decode.succeed ALL

                    "OUTSIDE" ->
                        Decode.succeed OUTSIDE

                    _ ->
                        Decode.fail ("Invalid RepositoryCollaboratorAffiliation type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
