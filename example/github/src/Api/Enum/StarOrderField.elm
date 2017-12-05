module Api.Enum.StarOrderField exposing (..)

import Json.Decode as Decode exposing (Decoder)


type StarOrderField
    = STARRED_AT


decoder : Decoder StarOrderField
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "STARRED_AT" ->
                        Decode.succeed STARRED_AT

                    _ ->
                        Decode.fail ("Invalid StarOrderField type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
