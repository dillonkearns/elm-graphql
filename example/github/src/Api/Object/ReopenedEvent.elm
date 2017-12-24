module Api.Object.ReopenedEvent exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


selection : (a -> constructor) -> Object (a -> constructor) Api.Object.ReopenedEvent
selection constructor =
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
