module Api.Object.DeploymentStatus exposing (..)

import Api.Enum.DeploymentStatusState
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.DeploymentStatus
selection constructor =
    Object.object constructor


createdAt : FieldDecoder String Api.Object.DeploymentStatus
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


creator : SelectionSet creator Api.Object.Actor -> FieldDecoder creator Api.Object.DeploymentStatus
creator object =
    Object.single "creator" [] object


deployment : SelectionSet deployment Api.Object.Deployment -> FieldDecoder deployment Api.Object.DeploymentStatus
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
