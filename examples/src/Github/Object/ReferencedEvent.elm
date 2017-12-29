module Github.Object.ReferencedEvent exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ReferencedEvent
selection constructor =
    Object.object constructor


actor : SelectionSet actor Github.Object.Actor -> FieldDecoder (Maybe actor) Github.Object.ReferencedEvent
actor object =
    Object.selectionFieldDecoder "actor" [] object (identity >> Decode.maybe)


commit : SelectionSet commit Github.Object.Commit -> FieldDecoder (Maybe commit) Github.Object.ReferencedEvent
commit object =
    Object.selectionFieldDecoder "commit" [] object (identity >> Decode.maybe)


commitRepository : SelectionSet commitRepository Github.Object.Repository -> FieldDecoder commitRepository Github.Object.ReferencedEvent
commitRepository object =
    Object.selectionFieldDecoder "commitRepository" [] object identity


createdAt : FieldDecoder String Github.Object.ReferencedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Github.Object.ReferencedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


isCrossReference : FieldDecoder Bool Github.Object.ReferencedEvent
isCrossReference =
    Object.fieldDecoder "isCrossReference" [] Decode.bool


isCrossRepository : FieldDecoder Bool Github.Object.ReferencedEvent
isCrossRepository =
    Object.fieldDecoder "isCrossRepository" [] Decode.bool


isDirectReference : FieldDecoder Bool Github.Object.ReferencedEvent
isDirectReference =
    Object.fieldDecoder "isDirectReference" [] Decode.bool


subject : FieldDecoder (Maybe String) Github.Object.ReferencedEvent
subject =
    Object.fieldDecoder "subject" [] (Decode.string |> Decode.maybe)
