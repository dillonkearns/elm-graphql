module Api.Object.DeleteProjectPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


selection : (a -> constructor) -> Object (a -> constructor) Api.Object.DeleteProjectPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.DeleteProjectPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


owner : Object owner Api.Object.ProjectOwner -> FieldDecoder owner Api.Object.DeleteProjectPayload
owner object =
    Object.single "owner" [] object
