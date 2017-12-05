module Api.Object.AddProjectColumnPayload exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.AddProjectColumnPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.AddProjectColumnPayload
clientMutationId =
    Field.fieldDecoder "clientMutationId" [] Decode.string


columnEdge : Object columnEdge Api.Object.ProjectColumnEdge -> FieldDecoder columnEdge Api.Object.AddProjectColumnPayload
columnEdge object =
    Object.single "columnEdge" [] object


project : Object project Api.Object.Project -> FieldDecoder project Api.Object.AddProjectColumnPayload
project object =
    Object.single "project" [] object
