module Api.Enum.Episode exposing (..)

import Json.Decode as Decode exposing (Decoder)


type Episode
    = EMPIRE
    | JEDI
    | NEWHOPE


decoder : Decoder Episode
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "EMPIRE" ->
                        Decode.succeed EMPIRE

                    "JEDI" ->
                        Decode.succeed JEDI

                    "NEWHOPE" ->
                        Decode.succeed NEWHOPE

                    _ ->
                        Decode.fail ("Invalid Episode type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
