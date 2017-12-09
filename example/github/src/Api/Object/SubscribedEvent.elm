module Api.Object.SubscribedEvent exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


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
