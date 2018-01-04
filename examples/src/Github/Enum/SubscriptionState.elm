module Github.Enum.SubscriptionState exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The possible states of a subscription.

  - UNSUBSCRIBED - The User is only notified when particpating or @mentioned.
  - SUBSCRIBED - The User is notified of all conversations.
  - IGNORED - The User is never notified.
  - UNAVAILABLE - Subscriptions are currently unavailable

-}
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


toString : SubscriptionState -> String
toString enum =
    case enum of
        UNSUBSCRIBED ->
            "UNSUBSCRIBED"

        SUBSCRIBED ->
            "SUBSCRIBED"

        IGNORED ->
            "IGNORED"

        UNAVAILABLE ->
            "UNAVAILABLE"
