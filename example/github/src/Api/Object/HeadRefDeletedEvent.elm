module Api.Object.HeadRefDeletedEvent exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.HeadRefDeletedEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.HeadRefDeletedEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Api.Object.HeadRefDeletedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


headRef : Object headRef Api.Object.Ref -> FieldDecoder headRef Api.Object.HeadRefDeletedEvent
headRef object =
    Object.single "headRef" [] object


headRefName : FieldDecoder String Api.Object.HeadRefDeletedEvent
headRefName =
    Object.fieldDecoder "headRefName" [] Decode.string


id : FieldDecoder String Api.Object.HeadRefDeletedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


pullRequest : Object pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.HeadRefDeletedEvent
pullRequest object =
    Object.single "pullRequest" [] object
