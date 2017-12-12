module Api.Object.UpdateSubscriptionPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.UpdateSubscriptionPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.UpdateSubscriptionPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


subscribable : Object subscribable Api.Object.Subscribable -> FieldDecoder subscribable Api.Object.UpdateSubscriptionPayload
subscribable object =
    Object.single "subscribable" [] object
