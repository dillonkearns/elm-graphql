module Api.Object.Deployment exposing (..)

import Api.Enum.DeploymentState
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Deployment
build constructor =
    Object.object constructor


commit : Object commit Api.Object.Commit -> FieldDecoder commit Api.Object.Deployment
commit object =
    Object.single "commit" [] object


createdAt : FieldDecoder String Api.Object.Deployment
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


creator : Object creator Api.Object.Actor -> FieldDecoder creator Api.Object.Deployment
creator object =
    Object.single "creator" [] object


databaseId : FieldDecoder Int Api.Object.Deployment
databaseId =
    Field.fieldDecoder "databaseId" [] Decode.int


environment : FieldDecoder String Api.Object.Deployment
environment =
    Field.fieldDecoder "environment" [] Decode.string


id : FieldDecoder String Api.Object.Deployment
id =
    Field.fieldDecoder "id" [] Decode.string


latestStatus : Object latestStatus Api.Object.DeploymentStatus -> FieldDecoder latestStatus Api.Object.Deployment
latestStatus object =
    Object.single "latestStatus" [] object


payload : FieldDecoder String Api.Object.Deployment
payload =
    Field.fieldDecoder "payload" [] Decode.string


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.Deployment
repository object =
    Object.single "repository" [] object


state : FieldDecoder Api.Enum.DeploymentState.DeploymentState Api.Object.Deployment
state =
    Field.fieldDecoder "state" [] Api.Enum.DeploymentState.decoder


statuses : Object statuses Api.Object.DeploymentStatusConnection -> FieldDecoder statuses Api.Object.Deployment
statuses object =
    Object.single "statuses" [] object
