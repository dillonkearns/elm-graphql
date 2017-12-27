module Api.Object.Deployment exposing (..)

import Api.Enum.DeploymentState
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.Deployment
selection constructor =
    Object.object constructor


commit : SelectionSet commit Api.Object.Commit -> FieldDecoder commit Api.Object.Deployment
commit object =
    Object.single "commit" [] object


createdAt : FieldDecoder String Api.Object.Deployment
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


creator : SelectionSet creator Api.Object.Actor -> FieldDecoder creator Api.Object.Deployment
creator object =
    Object.single "creator" [] object


databaseId : FieldDecoder Int Api.Object.Deployment
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


environment : FieldDecoder String Api.Object.Deployment
environment =
    Object.fieldDecoder "environment" [] Decode.string


id : FieldDecoder String Api.Object.Deployment
id =
    Object.fieldDecoder "id" [] Decode.string


latestStatus : SelectionSet latestStatus Api.Object.DeploymentStatus -> FieldDecoder latestStatus Api.Object.Deployment
latestStatus object =
    Object.single "latestStatus" [] object


payload : FieldDecoder String Api.Object.Deployment
payload =
    Object.fieldDecoder "payload" [] Decode.string


repository : SelectionSet repository Api.Object.Repository -> FieldDecoder repository Api.Object.Deployment
repository object =
    Object.single "repository" [] object


state : FieldDecoder Api.Enum.DeploymentState.DeploymentState Api.Object.Deployment
state =
    Object.fieldDecoder "state" [] Api.Enum.DeploymentState.decoder


statuses : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet statuses Api.Object.DeploymentStatusConnection -> FieldDecoder statuses Api.Object.Deployment
statuses fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "statuses" optionalArgs object
