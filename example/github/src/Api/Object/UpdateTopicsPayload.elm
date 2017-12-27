module Api.Object.UpdateTopicsPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.UpdateTopicsPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.UpdateTopicsPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


invalidTopicNames : FieldDecoder (List String) Api.Object.UpdateTopicsPayload
invalidTopicNames =
    Object.fieldDecoder "invalidTopicNames" [] (Decode.string |> Decode.list)


repository : SelectionSet repository Api.Object.Repository -> FieldDecoder repository Api.Object.UpdateTopicsPayload
repository object =
    Object.single "repository" [] object
