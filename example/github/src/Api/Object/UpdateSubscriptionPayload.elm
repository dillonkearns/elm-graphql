module Api.Object.UpdateSubscriptionPayload exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.UpdateSubscriptionPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.UpdateSubscriptionPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


subscribable : Object subscribable Api.Object.Subscribable -> FieldDecoder subscribable Api.Object.UpdateSubscriptionPayload
subscribable object =
    Object.single "subscribable" [] object
