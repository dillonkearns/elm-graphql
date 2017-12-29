module Github.Object.UnassignedEvent exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.UnassignedEvent
selection constructor =
    Object.object constructor


actor : SelectionSet actor Github.Object.Actor -> FieldDecoder (Maybe actor) Github.Object.UnassignedEvent
actor object =
    Object.selectionFieldDecoder "actor" [] object (identity >> Decode.maybe)


assignable : SelectionSet assignable Github.Object.Assignable -> FieldDecoder assignable Github.Object.UnassignedEvent
assignable object =
    Object.selectionFieldDecoder "assignable" [] object identity


createdAt : FieldDecoder String Github.Object.UnassignedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Github.Object.UnassignedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


user : SelectionSet user Github.Object.User -> FieldDecoder (Maybe user) Github.Object.UnassignedEvent
user object =
    Object.selectionFieldDecoder "user" [] object (identity >> Decode.maybe)
