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


{-| Identifies the date and time when the object was created.
-}
createdAt : FieldDecoder String Github.Object.DeploymentStatus
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


{-| Identifies the actor who triggered the deployment.
-}
creator : SelectionSet creator Github.Object.Actor -> FieldDecoder (Maybe creator) Github.Object.DeploymentStatus
creator object =
    Object.selectionFieldDecoder "creator" [] object (identity >> Decode.maybe)


{-| Identifies the deployment associated with status.
-}
deployment : SelectionSet deployment Github.Object.Deployment -> FieldDecoder deployment Github.Object.DeploymentStatus
deployment object =
    Object.selectionFieldDecoder "deployment" [] object identity


{-| Identifies the description of the deployment.
-}
description : FieldDecoder (Maybe String) Github.Object.DeploymentStatus
description =
    Object.fieldDecoder "description" [] (Decode.string |> Decode.maybe)


{-| Identifies the environment URL of the deployment.
-}
environmentUrl : FieldDecoder (Maybe String) Github.Object.DeploymentStatus
environmentUrl =
    Object.fieldDecoder "environmentUrl" [] (Decode.string |> Decode.maybe)


id : FieldDecoder String Github.Object.DeploymentStatus
id =
    Object.fieldDecoder "id" [] Decode.string


{-| Identifies the log URL of the deployment.
-}
logUrl : FieldDecoder (Maybe String) Github.Object.DeploymentStatus
logUrl =
    Object.fieldDecoder "logUrl" [] (Decode.string |> Decode.maybe)


{-| Identifies the current state of the deployment.
-}
state : FieldDecoder Github.Enum.DeploymentStatusState.DeploymentStatusState Github.Object.DeploymentStatus
state =
    Object.fieldDecoder "state" [] Github.Enum.DeploymentStatusState.decoder


{-| Identifies the date and time when the object was last updated.
-}
updatedAt : FieldDecoder String Github.Object.DeploymentStatus
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string
