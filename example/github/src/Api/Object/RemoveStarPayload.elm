module Api.Object.RemoveStarPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.RemoveStarPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.RemoveStarPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


starrable : SelectionSet starrable Api.Object.Starrable -> FieldDecoder starrable Api.Object.RemoveStarPayload
starrable object =
    Object.single "starrable" [] object
