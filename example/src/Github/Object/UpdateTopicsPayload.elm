module Github.Object.UpdateTopicsPayload exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.UpdateTopicsPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Github.Object.UpdateTopicsPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


invalidTopicNames : FieldDecoder (List String) Github.Object.UpdateTopicsPayload
invalidTopicNames =
    Object.fieldDecoder "invalidTopicNames" [] (Decode.string |> Decode.list)


repository : SelectionSet repository Github.Object.Repository -> FieldDecoder repository Github.Object.UpdateTopicsPayload
repository object =
    Object.single "repository" [] object
