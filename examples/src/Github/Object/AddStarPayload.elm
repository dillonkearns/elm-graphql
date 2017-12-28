module Github.Object.AddStarPayload exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.AddStarPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Github.Object.AddStarPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


starrable : SelectionSet starrable Github.Object.Starrable -> FieldDecoder starrable Github.Object.AddStarPayload
starrable object =
    Object.selectionFieldDecoder "starrable" [] object identity
