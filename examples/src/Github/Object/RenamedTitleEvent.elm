module Github.Object.RenamedTitleEvent exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.RenamedTitleEvent
selection constructor =
    Object.object constructor


actor : SelectionSet actor Github.Object.Actor -> FieldDecoder actor Github.Object.RenamedTitleEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Github.Object.RenamedTitleEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


currentTitle : FieldDecoder String Github.Object.RenamedTitleEvent
currentTitle =
    Object.fieldDecoder "currentTitle" [] Decode.string


id : FieldDecoder String Github.Object.RenamedTitleEvent
id =
    Object.fieldDecoder "id" [] Decode.string


previousTitle : FieldDecoder String Github.Object.RenamedTitleEvent
previousTitle =
    Object.fieldDecoder "previousTitle" [] Decode.string


subject : FieldDecoder String Github.Object.RenamedTitleEvent
subject =
    Object.fieldDecoder "subject" [] Decode.string
