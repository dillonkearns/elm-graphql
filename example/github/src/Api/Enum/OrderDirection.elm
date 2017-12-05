module Api.Enum.OrderDirection exposing (..)

import Json.Decode as Decode exposing (Decoder)


type OrderDirection
    = ASC
    | DESC


decoder : Decoder OrderDirection
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "ASC" ->
                        Decode.succeed ASC

                    "DESC" ->
                        Decode.succeed DESC

                    _ ->
                        Decode.fail ("Invalid OrderDirection type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
