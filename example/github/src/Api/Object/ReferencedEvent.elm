module Api.Object.ReferencedEvent exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.ReferencedEvent
selection constructor =
    Object.object constructor


actor : SelectionSet actor Api.Object.Actor -> FieldDecoder actor Api.Object.ReferencedEvent
actor object =
    Object.single "actor" [] object


commit : SelectionSet commit Api.Object.Commit -> FieldDecoder commit Api.Object.ReferencedEvent
commit object =
    Object.single "commit" [] object


commitRepository : SelectionSet commitRepository Api.Object.Repository -> FieldDecoder commitRepository Api.Object.ReferencedEvent
commitRepository object =
    Object.single "commitRepository" [] object


createdAt : FieldDecoder String Api.Object.ReferencedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Api.Object.ReferencedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


isCrossReference : FieldDecoder Bool Api.Object.ReferencedEvent
isCrossReference =
    Object.fieldDecoder "isCrossReference" [] Decode.bool


isCrossRepository : FieldDecoder Bool Api.Object.ReferencedEvent
isCrossRepository =
    Object.fieldDecoder "isCrossRepository" [] Decode.bool


isDirectReference : FieldDecoder Bool Api.Object.ReferencedEvent
isDirectReference =
    Object.fieldDecoder "isDirectReference" [] Decode.bool


subject : FieldDecoder String Api.Object.ReferencedEvent
subject =
    Object.fieldDecoder "subject" [] Decode.string
