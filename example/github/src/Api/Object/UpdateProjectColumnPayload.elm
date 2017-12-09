module Api.Object.UpdateProjectColumnPayload exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.UpdateProjectColumnPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.UpdateProjectColumnPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


projectColumn : Object projectColumn Api.Object.ProjectColumn -> FieldDecoder projectColumn Api.Object.UpdateProjectColumnPayload
projectColumn object =
    Object.single "projectColumn" [] object
