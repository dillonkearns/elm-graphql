module Api.Object.DeployedEvent exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.DeployedEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.DeployedEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Api.Object.DeployedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder Int Api.Object.DeployedEvent
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


deployment : Object deployment Api.Object.Deployment -> FieldDecoder deployment Api.Object.DeployedEvent
deployment object =
    Object.single "deployment" [] object


id : FieldDecoder String Api.Object.DeployedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


pullRequest : Object pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.DeployedEvent
pullRequest object =
    Object.single "pullRequest" [] object


ref : Object ref Api.Object.Ref -> FieldDecoder ref Api.Object.DeployedEvent
ref object =
    Object.single "ref" [] object
