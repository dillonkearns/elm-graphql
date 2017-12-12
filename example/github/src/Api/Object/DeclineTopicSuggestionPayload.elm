module Api.Object.DeclineTopicSuggestionPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.DeclineTopicSuggestionPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.DeclineTopicSuggestionPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


topic : Object topic Api.Object.Topic -> FieldDecoder topic Api.Object.DeclineTopicSuggestionPayload
topic object =
    Object.single "topic" [] object
