module Api.Object.RemoveOutsideCollaboratorPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RemoveOutsideCollaboratorPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.RemoveOutsideCollaboratorPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


removedUser : Object removedUser Api.Object.User -> FieldDecoder removedUser Api.Object.RemoveOutsideCollaboratorPayload
removedUser object =
    Object.single "removedUser" [] object
