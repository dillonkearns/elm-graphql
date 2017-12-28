module Github.Object.Deployment exposing (..)

import Github.Enum.DeploymentState
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Deployment
selection constructor =
    Object.object constructor


commit : SelectionSet commit Github.Object.Commit -> FieldDecoder commit Github.Object.Deployment
commit object =
    Object.selectionFieldDecoder "commit" [] object identity


createdAt : FieldDecoder String Github.Object.Deployment
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


creator : SelectionSet creator Github.Object.Actor -> FieldDecoder creator Github.Object.Deployment
creator object =
    Object.selectionFieldDecoder "creator" [] object identity


databaseId : FieldDecoder Int Github.Object.Deployment
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


environment : FieldDecoder String Github.Object.Deployment
environment =
    Object.fieldDecoder "environment" [] Decode.string


id : FieldDecoder String Github.Object.Deployment
id =
    Object.fieldDecoder "id" [] Decode.string


latestStatus : SelectionSet latestStatus Github.Object.DeploymentStatus -> FieldDecoder latestStatus Github.Object.Deployment
latestStatus object =
    Object.selectionFieldDecoder "latestStatus" [] object identity


payload : FieldDecoder String Github.Object.Deployment
payload =
    Object.fieldDecoder "payload" [] Decode.string


repository : SelectionSet repository Github.Object.Repository -> FieldDecoder repository Github.Object.Deployment
repository object =
    Object.selectionFieldDecoder "repository" [] object identity


state : FieldDecoder Github.Enum.DeploymentState.DeploymentState Github.Object.Deployment
state =
    Object.fieldDecoder "state" [] Github.Enum.DeploymentState.decoder


statuses : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet statuses Github.Object.DeploymentStatusConnection -> FieldDecoder statuses Github.Object.Deployment
statuses fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "statuses" optionalArgs object identity
