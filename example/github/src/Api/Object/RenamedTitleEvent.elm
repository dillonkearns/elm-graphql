module Api.Object.RenamedTitleEvent exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RenamedTitleEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.RenamedTitleEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Api.Object.RenamedTitleEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


currentTitle : FieldDecoder String Api.Object.RenamedTitleEvent
currentTitle =
    Object.fieldDecoder "currentTitle" [] Decode.string


id : FieldDecoder String Api.Object.RenamedTitleEvent
id =
    Object.fieldDecoder "id" [] Decode.string


previousTitle : FieldDecoder String Api.Object.RenamedTitleEvent
previousTitle =
    Object.fieldDecoder "previousTitle" [] Decode.string


subject : FieldDecoder String Api.Object.RenamedTitleEvent
subject =
    Object.fieldDecoder "subject" [] Decode.string
