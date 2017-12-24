module Api.Object.CreateProjectPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.CreateProjectPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.CreateProjectPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


project : SelectionSet project Api.Object.Project -> FieldDecoder project Api.Object.CreateProjectPayload
project object =
    Object.single "project" [] object
