module Api.Enum.SubscriptionState exposing (..)

import Json.Decode as Decode exposing (Decoder)


type SubscriptionState
    = UNSUBSCRIBED
    | SUBSCRIBED
    | IGNORED
    | UNAVAILABLE


decoder : Decoder SubscriptionState
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "UNSUBSCRIBED" ->
                        Decode.succeed UNSUBSCRIBED

                    "SUBSCRIBED" ->
                        Decode.succeed SUBSCRIBED

                    "IGNORED" ->
                        Decode.succeed IGNORED

                    "UNAVAILABLE" ->
                        Decode.succeed UNAVAILABLE

                    _ ->
                        Decode.fail ("Invalid SubscriptionState type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
