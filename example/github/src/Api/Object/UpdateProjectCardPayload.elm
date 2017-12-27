module Api.Object.UpdateProjectCardPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.UpdateProjectCardPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.UpdateProjectCardPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


projectCard : SelectionSet projectCard Api.Object.ProjectCard -> FieldDecoder projectCard Api.Object.UpdateProjectCardPayload
projectCard object =
    Object.single "projectCard" [] object
