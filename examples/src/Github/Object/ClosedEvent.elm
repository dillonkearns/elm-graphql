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


actor : SelectionSet actor Github.Object.Actor -> FieldDecoder actor Github.Object.ClosedEvent
actor object =
    Object.single "actor" [] object


closable : SelectionSet closable Github.Object.Closable -> FieldDecoder closable Github.Object.ClosedEvent
closable object =
    Object.single "closable" [] object


commit : SelectionSet commit Github.Object.Commit -> FieldDecoder commit Github.Object.ClosedEvent
commit object =
    Object.single "commit" [] object


createdAt : FieldDecoder String Github.Object.ClosedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Github.Object.ClosedEvent
id =
    Object.fieldDecoder "id" [] Decode.string
