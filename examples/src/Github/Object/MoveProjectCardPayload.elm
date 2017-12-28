module Github.Object.MoveProjectCardPayload exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.MoveProjectCardPayload
selection constructor =
    Object.object constructor


cardEdge : SelectionSet cardEdge Github.Object.ProjectCardEdge -> FieldDecoder cardEdge Github.Object.MoveProjectCardPayload
cardEdge object =
    Object.selectionFieldDecoder "cardEdge" [] object identity


clientMutationId : FieldDecoder String Github.Object.MoveProjectCardPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string
