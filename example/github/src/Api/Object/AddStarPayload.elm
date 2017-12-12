module Api.Object.AddStarPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.AddStarPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.AddStarPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


starrable : Object starrable Api.Object.Starrable -> FieldDecoder starrable Api.Object.AddStarPayload
starrable object =
    Object.single "starrable" [] object
