module Api.Object.AssignedEvent exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.AssignedEvent
selection constructor =
    Object.object constructor


actor : SelectionSet actor Api.Object.Actor -> FieldDecoder actor Api.Object.AssignedEvent
actor object =
    Object.single "actor" [] object


assignable : SelectionSet assignable Api.Object.Assignable -> FieldDecoder assignable Api.Object.AssignedEvent
assignable object =
    Object.single "assignable" [] object


createdAt : FieldDecoder String Api.Object.AssignedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Api.Object.AssignedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


user : SelectionSet user Api.Object.User -> FieldDecoder user Api.Object.AssignedEvent
user object =
    Object.single "user" [] object
