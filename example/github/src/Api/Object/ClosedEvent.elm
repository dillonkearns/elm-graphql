module Api.Object.ClosedEvent exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ClosedEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.ClosedEvent
actor object =
    Object.single "actor" [] object


closable : Object closable Api.Object.Closable -> FieldDecoder closable Api.Object.ClosedEvent
closable object =
    Object.single "closable" [] object


commit : Object commit Api.Object.Commit -> FieldDecoder commit Api.Object.ClosedEvent
commit object =
    Object.single "commit" [] object


createdAt : FieldDecoder String Api.Object.ClosedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Api.Object.ClosedEvent
id =
    Object.fieldDecoder "id" [] Decode.string
