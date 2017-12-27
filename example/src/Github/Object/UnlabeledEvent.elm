module Github.Object.UnlabeledEvent exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.UnlabeledEvent
selection constructor =
    Object.object constructor


actor : SelectionSet actor Github.Object.Actor -> FieldDecoder actor Github.Object.UnlabeledEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Github.Object.UnlabeledEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Github.Object.UnlabeledEvent
id =
    Object.fieldDecoder "id" [] Decode.string


label : SelectionSet label Github.Object.Label -> FieldDecoder label Github.Object.UnlabeledEvent
label object =
    Object.single "label" [] object


labelable : SelectionSet labelable Github.Object.Labelable -> FieldDecoder labelable Github.Object.UnlabeledEvent
labelable object =
    Object.single "labelable" [] object
