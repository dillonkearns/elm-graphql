module Github.Object.LabeledEvent exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.LabeledEvent
selection constructor =
    Object.object constructor


actor : SelectionSet actor Github.Object.Actor -> FieldDecoder actor Github.Object.LabeledEvent
actor object =
    Object.selectionFieldDecoder "actor" [] object identity


createdAt : FieldDecoder String Github.Object.LabeledEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Github.Object.LabeledEvent
id =
    Object.fieldDecoder "id" [] Decode.string


label : SelectionSet label Github.Object.Label -> FieldDecoder label Github.Object.LabeledEvent
label object =
    Object.selectionFieldDecoder "label" [] object identity


labelable : SelectionSet labelable Github.Object.Labelable -> FieldDecoder labelable Github.Object.LabeledEvent
labelable object =
    Object.selectionFieldDecoder "labelable" [] object identity
