module Api.Object.AssignedEvent exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.AssignedEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.AssignedEvent
actor object =
    Object.single "actor" [] object


assignable : Object assignable Api.Object.Assignable -> FieldDecoder assignable Api.Object.AssignedEvent
assignable object =
    Object.single "assignable" [] object


createdAt : FieldDecoder String Api.Object.AssignedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Api.Object.AssignedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


user : Object user Api.Object.User -> FieldDecoder user Api.Object.AssignedEvent
user object =
    Object.single "user" [] object
