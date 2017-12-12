module Api.Object.MoveProjectCardPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.MoveProjectCardPayload
build constructor =
    Object.object constructor


cardEdge : Object cardEdge Api.Object.ProjectCardEdge -> FieldDecoder cardEdge Api.Object.MoveProjectCardPayload
cardEdge object =
    Object.single "cardEdge" [] object


clientMutationId : FieldDecoder String Api.Object.MoveProjectCardPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string
