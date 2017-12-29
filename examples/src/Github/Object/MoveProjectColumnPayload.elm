module Github.Object.MoveProjectColumnPayload exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.MoveProjectColumnPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder (Maybe String) Github.Object.MoveProjectColumnPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] (Decode.string |> Decode.maybe)


columnEdge : SelectionSet columnEdge Github.Object.ProjectColumnEdge -> FieldDecoder columnEdge Github.Object.MoveProjectColumnPayload
columnEdge object =
    Object.selectionFieldDecoder "columnEdge" [] object identity
