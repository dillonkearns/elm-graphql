module Graphqelm.Subscription.Protocol exposing (Protocol, Response(..), phoenixAbsinthe, rails)

{-| You will need a Protocol data structure that fills in the low-level details about
your server's GraphQL Subscription protocol. Ideally these will be published here,
or in an external package by community members so that the protocols for each framework
is easily accessible, less error-prone, and more stable.

@docs Protocol, phoenixAbsinthe, rails, Response

-}

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode


{-| This encapsulates the Subscriptions protocol for a specific framework, like Phoenix/Absinthe.
The low-level details of how to initiate a connection and check that it was successful, etc., can be
very different between GraphQL server implementations. Here is an example for the Absinthe framework
for Elixir/Phoenix:

        frameworkKnowledge : Graphqelm.Subscription.Protocol subscriptionDecodesTo
        frameworkKnowledge =
        { initMessage =
        Encode.list
            [ Encode.string "1"
            , Encode.string "1"
            , Encode.string "__absinthe__:control"
            , Encode.string "phx_join"
            , Encode.object []
            ]
        , heartBeatMessage =
        Encode.list
            [ Encode.null
            , Encode.string "1"
            , Encode.string "phoenix"
            , Encode.string "heartbeat"
            , Encode.object []
            ]
        , documentRequest =
        \operation ->
            Encode.list
                [ Encode.string "1"
                , Encode.string "1"
                , Encode.string "__absinthe__:control"
                , Encode.string "doc"
                , Encode.object [ ( "query", operation |> Encode.string ) ]
                ]
        , subscriptionDecoder =
        \decoder ->
            subscriptionResponseDecoder
                (decoder
                    |> Decode.field "result"
                    |> Decode.index 4
                )
        }

-}
type alias Protocol subscriptionDecodesTo =
    { documentRequest : Int -> String -> Encode.Value
    , heartBeatMessage : Int -> Encode.Value
    , initMessage : Int -> Encode.Value
    , subscriptionDecoder :
        Decoder subscriptionDecodesTo
        -> Decoder (Response subscriptionDecodesTo)
    }


{-| Low-level type used for building Protocol. Represents incoming server messages.
-}
type Response a
    = SubscriptionDataReceived a
    | HealthStatus
    | Ignored String


{-| `Protocol` for the [Absinthe framework](http://absinthe-graphql.org/)
with Elixir/Phoenix.
-}
phoenixAbsinthe : Protocol subscriptionDecodesTo
phoenixAbsinthe =
    { initMessage =
        \referenceId ->
            Encode.list
                [ Encode.null
                , Encode.string (toString referenceId)
                , Encode.string "__absinthe__:control"
                , Encode.string "phx_join"
                , Encode.object []
                ]
    , heartBeatMessage =
        \referenceId ->
            Encode.list
                [ Encode.null
                , Encode.string (toString referenceId)
                , Encode.string "phoenix"
                , Encode.string "heartbeat"
                , Encode.object []
                ]
    , documentRequest =
        \referenceId operation ->
            Encode.list
                [ Encode.string "1"
                , Encode.string (toString referenceId)
                , Encode.string "__absinthe__:control"
                , Encode.string "doc"
                , Encode.object [ ( "query", operation |> Encode.string ) ]
                ]
    , subscriptionDecoder =
        \decoder ->
            subscriptionResponseDecoder
                (decoder
                    |> Decode.field "result"
                    |> Decode.index 4
                )
    }


subscriptionResponseDecoder : Decode.Decoder a -> Decode.Decoder (Response a)
subscriptionResponseDecoder decoder =
    Decode.index 3 Decode.string
        |> Decode.andThen
            (\responseType ->
                if responseType == "subscription:data" then
                    decoder |> Decode.map SubscriptionDataReceived

                else
                    Decode.succeed HealthStatus
            )


{-| `Protocol` for [graphql-ruby](https://github.com/rmosolgo/graphql-ruby/).
-}
rails : Protocol subscriptionDecodesTo
rails =
    { initMessage =
        \referenceId ->
            Encode.object
                [ ( "command", Encode.string "subscribe" )
                , ( "identifier", Encode.string "{\"channel\":\"GraphqlChannel\",\"channelId\":\"ElmGraphql\"}" )
                ]
    , heartBeatMessage =
        \referenceId ->
            Encode.list
                [ Encode.null
                , Encode.string (toString referenceId)
                , Encode.string "phoenix"
                , Encode.string "heartbeat"
                , Encode.object []
                ]
    , documentRequest =
        \referenceId operation ->
            -- identifier and data are redundantly JSON encoded as per the Action Cable protocol, see:
            --  https://github.com/NullVoxPopuli/action_cable_client#the-action-cable-protocol
            Encode.object
                [ ( "command", Encode.string "message" )
                , ( "identifier"
                  , Encode.string
                        (Encode.object [ ( "channel", Encode.string "GraphqlChannel" ), ( "channelId", Encode.string "ElmGraphql" ) ] |> Encode.encode 0)
                  )
                , ( "data"
                  , Encode.object
                        [ ( "query", operation |> Encode.string )
                        , ( "action", Encode.string "execute" )
                        ]
                        |> Encode.encode 0
                        |> Encode.string
                  )
                ]
    , subscriptionDecoder =
        \decoder ->
            Decode.oneOf
                [ Decode.at [ "message", "result" ] decoder
                    |> Decode.map SubscriptionDataReceived
                , Decode.field "type" Decode.string
                    |> Decode.andThen
                        (\type_ ->
                            if type_ == "confirm_subscription" then
                                Decode.succeed HealthStatus

                            else if type_ == "ping" then
                                Decode.succeed HealthStatus

                            else
                                Decode.succeed (Ignored ("Type was not confirm_subscription: " ++ type_))
                        )
                ]
    }
