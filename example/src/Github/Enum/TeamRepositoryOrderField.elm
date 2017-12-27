module Github.Enum.TeamRepositoryOrderField exposing (..)

import Json.Decode as Decode exposing (Decoder)


type TeamRepositoryOrderField
    = CREATED_AT
    | UPDATED_AT
    | PUSHED_AT
    | NAME
    | PERMISSION
    | STARGAZERS


decoder : Decoder TeamRepositoryOrderField
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "CREATED_AT" ->
                        Decode.succeed CREATED_AT

                    "UPDATED_AT" ->
                        Decode.succeed UPDATED_AT

                    "PUSHED_AT" ->
                        Decode.succeed PUSHED_AT

                    "NAME" ->
                        Decode.succeed NAME

                    "PERMISSION" ->
                        Decode.succeed PERMISSION

                    "STARGAZERS" ->
                        Decode.succeed STARGAZERS

                    _ ->
                        Decode.fail ("Invalid TeamRepositoryOrderField type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
