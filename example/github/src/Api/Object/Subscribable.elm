module Api.Object.Subscribable exposing (..)

import Api.Enum.SubscriptionState
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Subscribable
build constructor =
    Object.object constructor


id : FieldDecoder String Api.Object.Subscribable
id =
    Object.fieldDecoder "id" [] Decode.string


viewerCanSubscribe : FieldDecoder Bool Api.Object.Subscribable
viewerCanSubscribe =
    Object.fieldDecoder "viewerCanSubscribe" [] Decode.bool


viewerSubscription : FieldDecoder Api.Enum.SubscriptionState.SubscriptionState Api.Object.Subscribable
viewerSubscription =
    Object.fieldDecoder "viewerSubscription" [] Api.Enum.SubscriptionState.decoder
