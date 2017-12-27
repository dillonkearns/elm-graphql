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


actor : SelectionSet actor Github.Object.Actor -> FieldDecoder actor Github.Object.ReopenedEvent
actor object =
    Object.single "actor" [] object


closable : SelectionSet closable Github.Object.Closable -> FieldDecoder closable Github.Object.ReopenedEvent
closable object =
    Object.single "closable" [] object


createdAt : FieldDecoder String Github.Object.ReopenedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Github.Object.ReopenedEvent
id =
    Object.fieldDecoder "id" [] Decode.string
