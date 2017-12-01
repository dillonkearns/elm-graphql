module Api.Enum.Episode exposing (..)

import Json.Decode as Decode exposing (Decoder)


type Episode
    = NEWHOPE
    | EMPIRE
    | JEDI


decoder : Decoder Episode
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "NEWHOPE" ->
                        Decode.succeed NEWHOPE

                    "EMPIRE" ->
                        Decode.succeed EMPIRE

                    "JEDI" ->
                        Decode.succeed JEDI

                    _ ->
                        Decode.fail ("Invalid Episode type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
