module Api.Object.CommentDeletedEvent exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.CommentDeletedEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.CommentDeletedEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Api.Object.CommentDeletedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder Int Api.Object.CommentDeletedEvent
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


id : FieldDecoder String Api.Object.CommentDeletedEvent
id =
    Object.fieldDecoder "id" [] Decode.string
