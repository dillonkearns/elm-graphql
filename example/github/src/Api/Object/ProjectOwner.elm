module Api.Object.ProjectOwner exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ProjectOwner
build constructor =
    Object.object constructor


id : FieldDecoder String Api.Object.ProjectOwner
id =
    Field.fieldDecoder "id" [] Decode.string


project : { number : String } -> Object project Api.Object.Project -> FieldDecoder project Api.Object.ProjectOwner
project requiredArgs object =
    Object.single "project" [ Argument.string "number" requiredArgs.number ] object


projects : Object projects Api.Object.ProjectConnection -> FieldDecoder projects Api.Object.ProjectOwner
projects object =
    Object.single "projects" [] object


projectsResourcePath : FieldDecoder String Api.Object.ProjectOwner
projectsResourcePath =
    Field.fieldDecoder "projectsResourcePath" [] Decode.string


projectsUrl : FieldDecoder String Api.Object.ProjectOwner
projectsUrl =
    Field.fieldDecoder "projectsUrl" [] Decode.string


viewerCanCreateProjects : FieldDecoder Bool Api.Object.ProjectOwner
viewerCanCreateProjects =
    Field.fieldDecoder "viewerCanCreateProjects" [] Decode.bool
