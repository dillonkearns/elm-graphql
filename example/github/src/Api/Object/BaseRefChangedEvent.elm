module Api.Object.BaseRefChangedEvent exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.BaseRefChangedEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.BaseRefChangedEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Api.Object.BaseRefChangedEvent
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder Int Api.Object.BaseRefChangedEvent
databaseId =
    Field.fieldDecoder "databaseId" [] Decode.int


id : FieldDecoder String Api.Object.BaseRefChangedEvent
id =
    Field.fieldDecoder "id" [] Decode.string
