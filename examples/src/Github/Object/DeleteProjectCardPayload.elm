module Github.Object.DeleteProjectCardPayload exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.DeleteProjectCardPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Github.Object.DeleteProjectCardPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


column : SelectionSet column Github.Object.ProjectColumn -> FieldDecoder column Github.Object.DeleteProjectCardPayload
column object =
    Object.selectionFieldDecoder "column" [] object identity


deletedCardId : FieldDecoder String Github.Object.DeleteProjectCardPayload
deletedCardId =
    Object.fieldDecoder "deletedCardId" [] Decode.string
