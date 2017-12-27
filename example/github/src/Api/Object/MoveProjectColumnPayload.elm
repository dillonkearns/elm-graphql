module Api.Object.MoveProjectColumnPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.MoveProjectColumnPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.MoveProjectColumnPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


columnEdge : SelectionSet columnEdge Api.Object.ProjectColumnEdge -> FieldDecoder columnEdge Api.Object.MoveProjectColumnPayload
columnEdge object =
    Object.single "columnEdge" [] object
