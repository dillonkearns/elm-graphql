module Github.Object.DemilestonedEvent exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.DemilestonedEvent
selection constructor =
    Object.object constructor


actor : SelectionSet actor Github.Object.Actor -> FieldDecoder actor Github.Object.DemilestonedEvent
actor object =
    Object.selectionFieldDecoder "actor" [] object identity


createdAt : FieldDecoder String Github.Object.DemilestonedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Github.Object.DemilestonedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


milestoneTitle : FieldDecoder String Github.Object.DemilestonedEvent
milestoneTitle =
    Object.fieldDecoder "milestoneTitle" [] Decode.string


subject : FieldDecoder String Github.Object.DemilestonedEvent
subject =
    Object.fieldDecoder "subject" [] Decode.string
