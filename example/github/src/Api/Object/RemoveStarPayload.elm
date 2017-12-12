module Api.Object.RemoveStarPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RemoveStarPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.RemoveStarPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


starrable : Object starrable Api.Object.Starrable -> FieldDecoder starrable Api.Object.RemoveStarPayload
starrable object =
    Object.single "starrable" [] object
