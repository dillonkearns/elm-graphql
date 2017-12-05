module Api.Object.ReferencedEvent exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReferencedEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.ReferencedEvent
actor object =
    Object.single "actor" [] object


commit : Object commit Api.Object.Commit -> FieldDecoder commit Api.Object.ReferencedEvent
commit object =
    Object.single "commit" [] object


commitRepository : Object commitRepository Api.Object.Repository -> FieldDecoder commitRepository Api.Object.ReferencedEvent
commitRepository object =
    Object.single "commitRepository" [] object


createdAt : FieldDecoder String Api.Object.ReferencedEvent
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Api.Object.ReferencedEvent
id =
    Field.fieldDecoder "id" [] Decode.string


isCrossReference : FieldDecoder String Api.Object.ReferencedEvent
isCrossReference =
    Field.fieldDecoder "isCrossReference" [] Decode.string


isCrossRepository : FieldDecoder String Api.Object.ReferencedEvent
isCrossRepository =
    Field.fieldDecoder "isCrossRepository" [] Decode.string


isDirectReference : FieldDecoder String Api.Object.ReferencedEvent
isDirectReference =
    Field.fieldDecoder "isDirectReference" [] Decode.string


subject : FieldDecoder String Api.Object.ReferencedEvent
subject =
    Field.fieldDecoder "subject" [] Decode.string
