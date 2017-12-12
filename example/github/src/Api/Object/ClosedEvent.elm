module Api.Object.ClosedEvent exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


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
