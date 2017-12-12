module Api.Object.ConvertedNoteToIssueEvent exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ConvertedNoteToIssueEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.ConvertedNoteToIssueEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Api.Object.ConvertedNoteToIssueEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder Int Api.Object.ConvertedNoteToIssueEvent
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


id : FieldDecoder String Api.Object.ConvertedNoteToIssueEvent
id =
    Object.fieldDecoder "id" [] Decode.string
