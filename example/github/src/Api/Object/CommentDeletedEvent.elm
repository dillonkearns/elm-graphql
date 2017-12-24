module Api.Object.CommentDeletedEvent exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


selection : (a -> constructor) -> Object (a -> constructor) Api.Object.CommentDeletedEvent
selection constructor =
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
