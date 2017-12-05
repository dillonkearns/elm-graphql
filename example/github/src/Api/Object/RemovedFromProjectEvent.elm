module Api.Object.RemovedFromProjectEvent exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RemovedFromProjectEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.RemovedFromProjectEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Api.Object.RemovedFromProjectEvent
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder Int Api.Object.RemovedFromProjectEvent
databaseId =
    Field.fieldDecoder "databaseId" [] Decode.int


id : FieldDecoder String Api.Object.RemovedFromProjectEvent
id =
    Field.fieldDecoder "id" [] Decode.string
