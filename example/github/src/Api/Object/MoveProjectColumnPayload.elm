module Api.Object.MoveProjectColumnPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.MoveProjectColumnPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.MoveProjectColumnPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


columnEdge : Object columnEdge Api.Object.ProjectColumnEdge -> FieldDecoder columnEdge Api.Object.MoveProjectColumnPayload
columnEdge object =
    Object.single "columnEdge" [] object
