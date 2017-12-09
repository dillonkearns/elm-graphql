module Api.Object.LockedEvent exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.LockedEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.LockedEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Api.Object.LockedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Api.Object.LockedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


lockable : Object lockable Api.Object.Lockable -> FieldDecoder lockable Api.Object.LockedEvent
lockable object =
    Object.single "lockable" [] object
