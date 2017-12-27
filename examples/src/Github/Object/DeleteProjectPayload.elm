module Github.Object.DeleteProjectPayload exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.DeleteProjectPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Github.Object.DeleteProjectPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


owner : SelectionSet owner Github.Object.ProjectOwner -> FieldDecoder owner Github.Object.DeleteProjectPayload
owner object =
    Object.single "owner" [] object
