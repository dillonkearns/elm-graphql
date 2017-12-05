module Api.Enum.TeamRole exposing (..)

import Json.Decode as Decode exposing (Decoder)


type TeamRole
    = ADMIN
    | MEMBER


decoder : Decoder TeamRole
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "ADMIN" ->
                        Decode.succeed ADMIN

                    "MEMBER" ->
                        Decode.succeed MEMBER

                    _ ->
                        Decode.fail ("Invalid TeamRole type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
