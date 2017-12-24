module Api.Object.LockedEvent exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


selection : (a -> constructor) -> Object (a -> constructor) Api.Object.LockedEvent
selection constructor =
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
