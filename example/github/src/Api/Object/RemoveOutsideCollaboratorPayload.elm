module Api.Object.RemoveOutsideCollaboratorPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RemoveOutsideCollaboratorPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.RemoveOutsideCollaboratorPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


removedUser : Object removedUser Api.Object.User -> FieldDecoder removedUser Api.Object.RemoveOutsideCollaboratorPayload
removedUser object =
    Object.single "removedUser" [] object
