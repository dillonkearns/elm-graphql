module Github.Object.RemoveOutsideCollaboratorPayload exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.RemoveOutsideCollaboratorPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Github.Object.RemoveOutsideCollaboratorPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


removedUser : SelectionSet removedUser Github.Object.User -> FieldDecoder removedUser Github.Object.RemoveOutsideCollaboratorPayload
removedUser object =
    Object.single "removedUser" [] object
