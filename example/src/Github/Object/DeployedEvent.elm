module Github.Object.DeployedEvent exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.DeployedEvent
selection constructor =
    Object.object constructor


actor : SelectionSet actor Github.Object.Actor -> FieldDecoder actor Github.Object.DeployedEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Github.Object.DeployedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder Int Github.Object.DeployedEvent
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


deployment : SelectionSet deployment Github.Object.Deployment -> FieldDecoder deployment Github.Object.DeployedEvent
deployment object =
    Object.single "deployment" [] object


id : FieldDecoder String Github.Object.DeployedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


pullRequest : SelectionSet pullRequest Github.Object.PullRequest -> FieldDecoder pullRequest Github.Object.DeployedEvent
pullRequest object =
    Object.single "pullRequest" [] object


ref : SelectionSet ref Github.Object.Ref -> FieldDecoder ref Github.Object.DeployedEvent
ref object =
    Object.single "ref" [] object
