module Api.Object.MoveProjectColumnPayload exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.MoveProjectColumnPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.MoveProjectColumnPayload
clientMutationId =
    Field.fieldDecoder "clientMutationId" [] Decode.string


columnEdge : Object columnEdge Api.Object.ProjectColumnEdge -> FieldDecoder columnEdge Api.Object.MoveProjectColumnPayload
columnEdge object =
    Object.single "columnEdge" [] object
