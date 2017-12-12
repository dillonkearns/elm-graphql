module Api.Object.AddReactionPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.AddReactionPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.AddReactionPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


reaction : Object reaction Api.Object.Reaction -> FieldDecoder reaction Api.Object.AddReactionPayload
reaction object =
    Object.single "reaction" [] object


subject : Object subject Api.Object.Reactable -> FieldDecoder subject Api.Object.AddReactionPayload
subject object =
    Object.single "subject" [] object
