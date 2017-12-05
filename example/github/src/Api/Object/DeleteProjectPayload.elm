module Api.Object.DeleteProjectPayload exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.DeleteProjectPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.DeleteProjectPayload
clientMutationId =
    Field.fieldDecoder "clientMutationId" [] Decode.string


owner : Object owner Api.Object.ProjectOwner -> FieldDecoder owner Api.Object.DeleteProjectPayload
owner object =
    Object.single "owner" [] object
