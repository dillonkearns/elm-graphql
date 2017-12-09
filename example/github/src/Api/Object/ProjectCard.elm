module Api.Object.ProjectCard exposing (..)

import Api.Enum.ProjectCardState
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ProjectCard
build constructor =
    Object.object constructor


column : Object column Api.Object.ProjectColumn -> FieldDecoder column Api.Object.ProjectCard
column object =
    Object.single "column" [] object


content : FieldDecoder String Api.Object.ProjectCard
content =
    Object.fieldDecoder "content" [] Decode.string


createdAt : FieldDecoder String Api.Object.ProjectCard
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


creator : Object creator Api.Object.Actor -> FieldDecoder creator Api.Object.ProjectCard
creator object =
    Object.single "creator" [] object


databaseId : FieldDecoder Int Api.Object.ProjectCard
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


id : FieldDecoder String Api.Object.ProjectCard
id =
    Object.fieldDecoder "id" [] Decode.string


note : FieldDecoder String Api.Object.ProjectCard
note =
    Object.fieldDecoder "note" [] Decode.string


project : Object project Api.Object.Project -> FieldDecoder project Api.Object.ProjectCard
project object =
    Object.single "project" [] object


projectColumn : Object projectColumn Api.Object.ProjectColumn -> FieldDecoder projectColumn Api.Object.ProjectCard
projectColumn object =
    Object.single "projectColumn" [] object


resourcePath : FieldDecoder String Api.Object.ProjectCard
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


state : FieldDecoder Api.Enum.ProjectCardState.ProjectCardState Api.Object.ProjectCard
state =
    Object.fieldDecoder "state" [] Api.Enum.ProjectCardState.decoder


updatedAt : FieldDecoder String Api.Object.ProjectCard
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.ProjectCard
url =
    Object.fieldDecoder "url" [] Decode.string
