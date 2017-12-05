module Api.Object.ProjectColumn exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ProjectColumn
build constructor =
    Object.object constructor


cards : Object cards Api.Object.ProjectCardConnection -> FieldDecoder cards Api.Object.ProjectColumn
cards object =
    Object.single "cards" [] object


createdAt : FieldDecoder String Api.Object.ProjectColumn
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder String Api.Object.ProjectColumn
databaseId =
    Field.fieldDecoder "databaseId" [] Decode.string


id : FieldDecoder String Api.Object.ProjectColumn
id =
    Field.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Api.Object.ProjectColumn
name =
    Field.fieldDecoder "name" [] Decode.string


project : Object project Api.Object.Project -> FieldDecoder project Api.Object.ProjectColumn
project object =
    Object.single "project" [] object


resourcePath : FieldDecoder String Api.Object.ProjectColumn
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


updatedAt : FieldDecoder String Api.Object.ProjectColumn
updatedAt =
    Field.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.ProjectColumn
url =
    Field.fieldDecoder "url" [] Decode.string
