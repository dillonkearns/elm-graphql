module Github.Object.ReopenedEvent exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ReopenedEvent
selection constructor =
    Object.object constructor


{-| Identifies the actor who performed the event.
-}
actor : SelectionSet actor Github.Object.Actor -> FieldDecoder (Maybe actor) Github.Object.ReopenedEvent
actor object =
    Object.selectionFieldDecoder "actor" [] object (identity >> Decode.maybe)


{-| Object that was reopened.
-}
closable : SelectionSet closable Github.Object.Closable -> FieldDecoder closable Github.Object.ReopenedEvent
closable object =
    Object.selectionFieldDecoder "closable" [] object identity


{-| Identifies the date and time when the object was created.
-}
createdAt : FieldDecoder String Github.Object.ReopenedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Github.Object.ReopenedEvent
id =
    Object.fieldDecoder "id" [] Decode.string
