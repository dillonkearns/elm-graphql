module Api.Object.DeploymentStatus exposing (..)

import Api.Enum.DeploymentStatusState
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.DeploymentStatus
build constructor =
    Object.object constructor


createdAt : FieldDecoder String Api.Object.DeploymentStatus
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


creator : Object creator Api.Object.Actor -> FieldDecoder creator Api.Object.DeploymentStatus
creator object =
    Object.single "creator" [] object


deployment : Object deployment Api.Object.Deployment -> FieldDecoder deployment Api.Object.DeploymentStatus
deployment object =
    Object.single "deployment" [] object


description : FieldDecoder String Api.Object.DeploymentStatus
description =
    Object.fieldDecoder "description" [] Decode.string


environmentUrl : FieldDecoder String Api.Object.DeploymentStatus
environmentUrl =
    Object.fieldDecoder "environmentUrl" [] Decode.string


id : FieldDecoder String Api.Object.DeploymentStatus
id =
    Object.fieldDecoder "id" [] Decode.string


logUrl : FieldDecoder String Api.Object.DeploymentStatus
logUrl =
    Object.fieldDecoder "logUrl" [] Decode.string


state : FieldDecoder Api.Enum.DeploymentStatusState.DeploymentStatusState Api.Object.DeploymentStatus
state =
    Object.fieldDecoder "state" [] Api.Enum.DeploymentStatusState.decoder


updatedAt : FieldDecoder String Api.Object.DeploymentStatus
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string
