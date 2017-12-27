module Github.Object.AcceptTopicSuggestionPayload exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.AcceptTopicSuggestionPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Github.Object.AcceptTopicSuggestionPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


topic : SelectionSet topic Github.Object.Topic -> FieldDecoder topic Github.Object.AcceptTopicSuggestionPayload
topic object =
    Object.single "topic" [] object
