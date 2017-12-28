module Github.Object.DeploymentStatus exposing (..)

import Github.Enum.DeploymentStatusState
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.DeploymentStatus
selection constructor =
    Object.object constructor


createdAt : FieldDecoder String Github.Object.DeploymentStatus
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


creator : SelectionSet creator Github.Object.Actor -> FieldDecoder creator Github.Object.DeploymentStatus
creator object =
    Object.selectionFieldDecoder "creator" [] object identity


deployment : SelectionSet deployment Github.Object.Deployment -> FieldDecoder deployment Github.Object.DeploymentStatus
deployment object =
    Object.selectionFieldDecoder "deployment" [] object identity


description : FieldDecoder String Github.Object.DeploymentStatus
description =
    Object.fieldDecoder "description" [] Decode.string


environmentUrl : FieldDecoder String Github.Object.DeploymentStatus
environmentUrl =
    Object.fieldDecoder "environmentUrl" [] Decode.string


id : FieldDecoder String Github.Object.DeploymentStatus
id =
    Object.fieldDecoder "id" [] Decode.string


logUrl : FieldDecoder String Github.Object.DeploymentStatus
logUrl =
    Object.fieldDecoder "logUrl" [] Decode.string


state : FieldDecoder Github.Enum.DeploymentStatusState.DeploymentStatusState Github.Object.DeploymentStatus
state =
    Object.fieldDecoder "state" [] Github.Enum.DeploymentStatusState.decoder


updatedAt : FieldDecoder String Github.Object.DeploymentStatus
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string
