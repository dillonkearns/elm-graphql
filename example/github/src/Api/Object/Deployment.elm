module Api.Object.Deployment exposing (..)

import Api.Enum.DeploymentState
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Deployment
build constructor =
    Object.object constructor


commit : Object commit Api.Object.Commit -> FieldDecoder commit Api.Object.Deployment
commit object =
    Object.single "commit" [] object


createdAt : FieldDecoder String Api.Object.Deployment
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


creator : Object creator Api.Object.Actor -> FieldDecoder creator Api.Object.Deployment
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


latestStatus : Object latestStatus Api.Object.DeploymentStatus -> FieldDecoder latestStatus Api.Object.Deployment
latestStatus object =
    Object.single "latestStatus" [] object


payload : FieldDecoder String Api.Object.Deployment
payload =
    Object.fieldDecoder "payload" [] Decode.string


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.Deployment
repository object =
    Object.single "repository" [] object


state : FieldDecoder Api.Enum.DeploymentState.DeploymentState Api.Object.Deployment
state =
    Object.fieldDecoder "state" [] Api.Enum.DeploymentState.decoder


statuses : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object statuses Api.Object.DeploymentStatusConnection -> FieldDecoder statuses Api.Object.Deployment
statuses fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string ]
                |> List.filterMap identity
    in
    Object.single "statuses" optionalArgs object
