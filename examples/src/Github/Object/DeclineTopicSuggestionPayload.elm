module Github.Object.DeclineTopicSuggestionPayload exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.DeclineTopicSuggestionPayload
selection constructor =
    Object.object constructor


{-| A unique identifier for the client performing the mutation.
-}
clientMutationId : FieldDecoder (Maybe String) Github.Object.DeclineTopicSuggestionPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] (Decode.string |> Decode.maybe)


{-| The declined topic.
-}
topic : SelectionSet topic Github.Object.Topic -> FieldDecoder topic Github.Object.DeclineTopicSuggestionPayload
topic object =
    Object.selectionFieldDecoder "topic" [] object identity
