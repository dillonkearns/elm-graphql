module Github.Object.UnassignedEvent exposing (..)

import Github.Interface
import Github.Object
import Github.Union
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


{-| Identifies the actor who performed the event.
-}
actor : SelectionSet selection Github.Interface.Actor -> FieldDecoder (Maybe selection) Github.Object.UnassignedEvent
actor object =
    Object.selectionFieldDecoder "actor" [] object (identity >> Decode.maybe)


{-| Identifies the assignable associated with the event.
-}
assignable : SelectionSet selection Github.Interface.Assignable -> FieldDecoder selection Github.Object.UnassignedEvent
assignable object =
    Object.selectionFieldDecoder "assignable" [] object identity


{-| Identifies the date and time when the object was created.
-}
createdAt : FieldDecoder String Github.Object.UnassignedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Github.Object.UnassignedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


{-| Identifies the subject (user) who was unassigned.
-}
user : SelectionSet selection Github.Object.User -> FieldDecoder (Maybe selection) Github.Object.UnassignedEvent
user object =
    Object.selectionFieldDecoder "user" [] object (identity >> Decode.maybe)
