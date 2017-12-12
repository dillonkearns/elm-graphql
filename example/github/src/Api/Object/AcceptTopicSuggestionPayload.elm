module Api.Object.AcceptTopicSuggestionPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.AcceptTopicSuggestionPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.AcceptTopicSuggestionPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


topic : Object topic Api.Object.Topic -> FieldDecoder topic Api.Object.AcceptTopicSuggestionPayload
topic object =
    Object.single "topic" [] object
