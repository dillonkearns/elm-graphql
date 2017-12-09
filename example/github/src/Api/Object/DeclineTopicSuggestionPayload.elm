module Api.Object.DeclineTopicSuggestionPayload exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.DeclineTopicSuggestionPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.DeclineTopicSuggestionPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


topic : Object topic Api.Object.Topic -> FieldDecoder topic Api.Object.DeclineTopicSuggestionPayload
topic object =
    Object.single "topic" [] object
