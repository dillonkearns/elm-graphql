module Api.Enum.ProjectOrderField exposing (..)

import Json.Decode as Decode exposing (Decoder)


type ProjectOrderField
    = CREATED_AT
    | UPDATED_AT
    | NAME


decoder : Decoder ProjectOrderField
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "CREATED_AT" ->
                        Decode.succeed CREATED_AT

                    "UPDATED_AT" ->
                        Decode.succeed UPDATED_AT

                    "NAME" ->
                        Decode.succeed NAME

                    _ ->
                        Decode.fail ("Invalid ProjectOrderField type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
