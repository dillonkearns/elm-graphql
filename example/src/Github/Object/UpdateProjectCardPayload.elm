module Github.Object.UpdateProjectCardPayload exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.UpdateProjectCardPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Github.Object.UpdateProjectCardPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


projectCard : SelectionSet projectCard Github.Object.ProjectCard -> FieldDecoder projectCard Github.Object.UpdateProjectCardPayload
projectCard object =
    Object.single "projectCard" [] object
