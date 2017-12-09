module Api.Object.UnlockedEvent exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.UnlockedEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.UnlockedEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Api.Object.UnlockedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Api.Object.UnlockedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


lockable : Object lockable Api.Object.Lockable -> FieldDecoder lockable Api.Object.UnlockedEvent
lockable object =
    Object.single "lockable" [] object
