module Github.Object.RemoveStarPayload exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.RemoveStarPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder (Maybe String) Github.Object.RemoveStarPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] (Decode.string |> Decode.maybe)


starrable : SelectionSet starrable Github.Object.Starrable -> FieldDecoder starrable Github.Object.RemoveStarPayload
starrable object =
    Object.selectionFieldDecoder "starrable" [] object identity
