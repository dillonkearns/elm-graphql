module Api.Object.RemoveReactionPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


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
