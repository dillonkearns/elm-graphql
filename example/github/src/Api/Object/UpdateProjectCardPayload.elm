module Api.Object.UpdateProjectCardPayload exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.UpdateProjectCardPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.UpdateProjectCardPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


projectCard : Object projectCard Api.Object.ProjectCard -> FieldDecoder projectCard Api.Object.UpdateProjectCardPayload
projectCard object =
    Object.single "projectCard" [] object
