module Api.Object.UpdateProjectCardPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.UpdateProjectCardPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.UpdateProjectCardPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


projectCard : Object projectCard Api.Object.ProjectCard -> FieldDecoder projectCard Api.Object.UpdateProjectCardPayload
projectCard object =
    Object.single "projectCard" [] object
