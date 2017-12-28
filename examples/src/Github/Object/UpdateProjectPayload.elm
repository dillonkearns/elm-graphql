module Github.Object.UpdateProjectPayload exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.UpdateProjectPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Github.Object.UpdateProjectPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


project : SelectionSet project Github.Object.Project -> FieldDecoder project Github.Object.UpdateProjectPayload
project object =
    Object.selectionFieldDecoder "project" [] object identity
