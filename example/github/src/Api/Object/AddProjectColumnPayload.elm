module Api.Object.AddProjectColumnPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.AddProjectColumnPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.AddProjectColumnPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


columnEdge : Object columnEdge Api.Object.ProjectColumnEdge -> FieldDecoder columnEdge Api.Object.AddProjectColumnPayload
columnEdge object =
    Object.single "columnEdge" [] object


project : Object project Api.Object.Project -> FieldDecoder project Api.Object.AddProjectColumnPayload
project object =
    Object.single "project" [] object
