module Api.Enum.CollaboratorAffiliation exposing (..)

import Json.Decode as Decode exposing (Decoder)


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
