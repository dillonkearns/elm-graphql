module Api.Object.UnsubscribedEvent exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


selection : (a -> constructor) -> Object (a -> constructor) Api.Object.UnsubscribedEvent
selection constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.UnsubscribedEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Api.Object.UnsubscribedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Api.Object.UnsubscribedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


subscribable : Object subscribable Api.Object.Subscribable -> FieldDecoder subscribable Api.Object.UnsubscribedEvent
subscribable object =
    Object.single "subscribable" [] object
