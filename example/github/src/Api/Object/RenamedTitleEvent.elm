module Api.Object.RenamedTitleEvent exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RenamedTitleEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.RenamedTitleEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Api.Object.RenamedTitleEvent
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


currentTitle : FieldDecoder String Api.Object.RenamedTitleEvent
currentTitle =
    Field.fieldDecoder "currentTitle" [] Decode.string


id : FieldDecoder String Api.Object.RenamedTitleEvent
id =
    Field.fieldDecoder "id" [] Decode.string


previousTitle : FieldDecoder String Api.Object.RenamedTitleEvent
previousTitle =
    Field.fieldDecoder "previousTitle" [] Decode.string


subject : FieldDecoder String Api.Object.RenamedTitleEvent
subject =
    Field.fieldDecoder "subject" [] Decode.string
