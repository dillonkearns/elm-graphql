module Api.Object.UpdateProjectPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.UpdateProjectPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.UpdateProjectPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


project : SelectionSet project Api.Object.Project -> FieldDecoder project Api.Object.UpdateProjectPayload
project object =
    Object.single "project" [] object
