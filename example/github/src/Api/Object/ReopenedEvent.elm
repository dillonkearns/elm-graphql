module Api.Object.ReopenedEvent exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReopenedEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.ReopenedEvent
actor object =
    Object.single "actor" [] object


closable : Object closable Api.Object.Closable -> FieldDecoder closable Api.Object.ReopenedEvent
closable object =
    Object.single "closable" [] object


createdAt : FieldDecoder String Api.Object.ReopenedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Api.Object.ReopenedEvent
id =
    Object.fieldDecoder "id" [] Decode.string
