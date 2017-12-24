module Api.Object.SubscribedEvent exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.SubscribedEvent
selection constructor =
    Object.object constructor


actor : SelectionSet actor Api.Object.Actor -> FieldDecoder actor Api.Object.SubscribedEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Api.Object.SubscribedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Api.Object.SubscribedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


subscribable : SelectionSet subscribable Api.Object.Subscribable -> FieldDecoder subscribable Api.Object.SubscribedEvent
subscribable object =
    Object.single "subscribable" [] object
