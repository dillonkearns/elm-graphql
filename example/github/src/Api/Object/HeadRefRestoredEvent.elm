module Api.Object.HeadRefRestoredEvent exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.HeadRefRestoredEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.HeadRefRestoredEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Api.Object.HeadRefRestoredEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Api.Object.HeadRefRestoredEvent
id =
    Object.fieldDecoder "id" [] Decode.string


pullRequest : Object pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.HeadRefRestoredEvent
pullRequest object =
    Object.single "pullRequest" [] object
