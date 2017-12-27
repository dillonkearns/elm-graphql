module Github.Enum.RepositoryOrderField exposing (..)

import Json.Decode as Decode exposing (Decoder)


type RepositoryOrderField
    = CREATED_AT
    | UPDATED_AT
    | PUSHED_AT
    | NAME
    | STARGAZERS


decoder : Decoder RepositoryOrderField
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

                    "STARGAZERS" ->
                        Decode.succeed STARGAZERS

                    _ ->
                        Decode.fail ("Invalid RepositoryOrderField type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
