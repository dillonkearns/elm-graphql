module Github.Enum.RepositoryPermission exposing (..)

import Json.Decode as Decode exposing (Decoder)


type RepositoryPermission
    = ADMIN
    | WRITE
    | READ


decoder : Decoder RepositoryPermission
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "ADMIN" ->
                        Decode.succeed ADMIN

                    "WRITE" ->
                        Decode.succeed WRITE

                    "READ" ->
                        Decode.succeed READ

                    _ ->
                        Decode.fail ("Invalid RepositoryPermission type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
