module Api.Object.HeadRefForcePushedEvent exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.HeadRefForcePushedEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.HeadRefForcePushedEvent
actor object =
    Object.single "actor" [] object


afterCommit : Object afterCommit Api.Object.Commit -> FieldDecoder afterCommit Api.Object.HeadRefForcePushedEvent
afterCommit object =
    Object.single "afterCommit" [] object


beforeCommit : Object beforeCommit Api.Object.Commit -> FieldDecoder beforeCommit Api.Object.HeadRefForcePushedEvent
beforeCommit object =
    Object.single "beforeCommit" [] object


createdAt : FieldDecoder String Api.Object.HeadRefForcePushedEvent
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Api.Object.HeadRefForcePushedEvent
id =
    Field.fieldDecoder "id" [] Decode.string


pullRequest : Object pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.HeadRefForcePushedEvent
pullRequest object =
    Object.single "pullRequest" [] object


ref : Object ref Api.Object.Ref -> FieldDecoder ref Api.Object.HeadRefForcePushedEvent
ref object =
    Object.single "ref" [] object
