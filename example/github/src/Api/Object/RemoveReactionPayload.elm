module Api.Object.RemoveReactionPayload exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RemoveReactionPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.RemoveReactionPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


reaction : Object reaction Api.Object.Reaction -> FieldDecoder reaction Api.Object.RemoveReactionPayload
reaction object =
    Object.single "reaction" [] object


subject : Object subject Api.Object.Reactable -> FieldDecoder subject Api.Object.RemoveReactionPayload
subject object =
    Object.single "subject" [] object
