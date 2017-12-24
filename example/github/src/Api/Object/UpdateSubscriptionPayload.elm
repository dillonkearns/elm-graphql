module Api.Object.UpdateSubscriptionPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.UpdateSubscriptionPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.UpdateSubscriptionPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


subscribable : SelectionSet subscribable Api.Object.Subscribable -> FieldDecoder subscribable Api.Object.UpdateSubscriptionPayload
subscribable object =
    Object.single "subscribable" [] object
