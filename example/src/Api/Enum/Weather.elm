module Api.Enum.Weather exposing (..)

import Json.Decode as Decode exposing (Decoder)


type Weather
    = CLOUDY
    | SUNNY


decoder : Decoder Weather
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "CLOUDY" ->
                        Decode.succeed CLOUDY

                    "SUNNY" ->
                        Decode.succeed SUNNY

                    _ ->
                        Decode.fail ("Invalid Weather type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
