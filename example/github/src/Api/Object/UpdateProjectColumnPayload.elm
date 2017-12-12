module Api.Object.UpdateProjectColumnPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.UpdateProjectColumnPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.UpdateProjectColumnPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


projectColumn : Object projectColumn Api.Object.ProjectColumn -> FieldDecoder projectColumn Api.Object.UpdateProjectColumnPayload
projectColumn object =
    Object.single "projectColumn" [] object
