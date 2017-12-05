module Api.Object.Project exposing (..)

import Api.Enum.ProjectState
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Project
build constructor =
    Object.object constructor


body : FieldDecoder String Api.Object.Project
body =
    Field.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Api.Object.Project
bodyHTML =
    Field.fieldDecoder "bodyHTML" [] Decode.string


closed : FieldDecoder String Api.Object.Project
closed =
    Field.fieldDecoder "closed" [] Decode.string


closedAt : FieldDecoder String Api.Object.Project
closedAt =
    Field.fieldDecoder "closedAt" [] Decode.string


columns : Object columns Api.Object.ProjectColumnConnection -> FieldDecoder columns Api.Object.Project
columns object =
    Object.single "columns" [] object


createdAt : FieldDecoder String Api.Object.Project
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


creator : Object creator Api.Object.Actor -> FieldDecoder creator Api.Object.Project
creator object =
    Object.single "creator" [] object


databaseId : FieldDecoder String Api.Object.Project
databaseId =
    Field.fieldDecoder "databaseId" [] Decode.string


id : FieldDecoder String Api.Object.Project
id =
    Field.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Api.Object.Project
name =
    Field.fieldDecoder "name" [] Decode.string


number : FieldDecoder String Api.Object.Project
number =
    Field.fieldDecoder "number" [] Decode.string


owner : Object owner Api.Object.ProjectOwner -> FieldDecoder owner Api.Object.Project
owner object =
    Object.single "owner" [] object


pendingCards : Object pendingCards Api.Object.ProjectCardConnection -> FieldDecoder pendingCards Api.Object.Project
pendingCards object =
    Object.single "pendingCards" [] object


resourcePath : FieldDecoder String Api.Object.Project
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


state : FieldDecoder Api.Enum.ProjectState.ProjectState Api.Object.Project
state =
    Field.fieldDecoder "state" [] Api.Enum.ProjectState.decoder


updatedAt : FieldDecoder String Api.Object.Project
updatedAt =
    Field.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.Project
url =
    Field.fieldDecoder "url" [] Decode.string


viewerCanUpdate : FieldDecoder String Api.Object.Project
viewerCanUpdate =
    Field.fieldDecoder "viewerCanUpdate" [] Decode.string
