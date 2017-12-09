module Api.Object.AcceptTopicSuggestionPayload exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.AcceptTopicSuggestionPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.AcceptTopicSuggestionPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


topic : Object topic Api.Object.Topic -> FieldDecoder topic Api.Object.AcceptTopicSuggestionPayload
topic object =
    Object.single "topic" [] object
