module Api.Object.DeleteProjectPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.DeleteProjectPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.DeleteProjectPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


owner : Object owner Api.Object.ProjectOwner -> FieldDecoder owner Api.Object.DeleteProjectPayload
owner object =
    Object.single "owner" [] object
