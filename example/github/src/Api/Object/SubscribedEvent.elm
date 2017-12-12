module Api.Object.SubscribedEvent exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.SubscribedEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.SubscribedEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Api.Object.SubscribedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Api.Object.SubscribedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


subscribable : Object subscribable Api.Object.Subscribable -> FieldDecoder subscribable Api.Object.SubscribedEvent
subscribable object =
    Object.single "subscribable" [] object
