module Github.Object.UpdateSubscriptionPayload exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.UpdateSubscriptionPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Github.Object.UpdateSubscriptionPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


subscribable : SelectionSet subscribable Github.Object.Subscribable -> FieldDecoder subscribable Github.Object.UpdateSubscriptionPayload
subscribable object =
    Object.selectionFieldDecoder "subscribable" [] object identity
