module Api.Enum.DefaultRepositoryPermissionField exposing (..)

import Json.Decode as Decode exposing (Decoder)


type DefaultRepositoryPermissionField
    = READ
    | WRITE
    | ADMIN


decoder : Decoder DefaultRepositoryPermissionField
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "READ" ->
                        Decode.succeed READ

                    "WRITE" ->
                        Decode.succeed WRITE

                    "ADMIN" ->
                        Decode.succeed ADMIN

                    _ ->
                        Decode.fail ("Invalid DefaultRepositoryPermissionField type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
