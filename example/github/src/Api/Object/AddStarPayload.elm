module Api.Object.AddStarPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.AddStarPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.AddStarPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


starrable : SelectionSet starrable Api.Object.Starrable -> FieldDecoder starrable Api.Object.AddStarPayload
starrable object =
    Object.single "starrable" [] object
