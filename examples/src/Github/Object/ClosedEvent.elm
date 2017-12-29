module Github.Object.ClosedEvent exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ClosedEvent
selection constructor =
    Object.object constructor


actor : SelectionSet actor Github.Object.Actor -> FieldDecoder (Maybe actor) Github.Object.ClosedEvent
actor object =
    Object.selectionFieldDecoder "actor" [] object (identity >> Decode.maybe)


closable : SelectionSet closable Github.Object.Closable -> FieldDecoder closable Github.Object.ClosedEvent
closable object =
    Object.selectionFieldDecoder "closable" [] object identity


commit : SelectionSet commit Github.Object.Commit -> FieldDecoder (Maybe commit) Github.Object.ClosedEvent
commit object =
    Object.selectionFieldDecoder "commit" [] object (identity >> Decode.maybe)


createdAt : FieldDecoder String Github.Object.ClosedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Github.Object.ClosedEvent
id =
    Object.fieldDecoder "id" [] Decode.string
