module Github.Object.Subscribable exposing (..)

import Github.Enum.SubscriptionState
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Subscribable
selection constructor =
    Object.object constructor


id : FieldDecoder String Github.Object.Subscribable
id =
    Object.fieldDecoder "id" [] Decode.string


{-| Check if the viewer is able to change their subscription status for the repository.
-}
viewerCanSubscribe : FieldDecoder Bool Github.Object.Subscribable
viewerCanSubscribe =
    Object.fieldDecoder "viewerCanSubscribe" [] Decode.bool


{-| Identifies if the viewer is watching, not watching, or ignoring the subscribable entity.
-}
viewerSubscription : FieldDecoder Github.Enum.SubscriptionState.SubscriptionState Github.Object.Subscribable
viewerSubscription =
    Object.fieldDecoder "viewerSubscription" [] Github.Enum.SubscriptionState.decoder
