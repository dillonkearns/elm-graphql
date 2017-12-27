module Api.Object.AddProjectColumnPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.AddProjectColumnPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.AddProjectColumnPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


columnEdge : SelectionSet columnEdge Api.Object.ProjectColumnEdge -> FieldDecoder columnEdge Api.Object.AddProjectColumnPayload
columnEdge object =
    Object.single "columnEdge" [] object


project : SelectionSet project Api.Object.Project -> FieldDecoder project Api.Object.AddProjectColumnPayload
project object =
    Object.single "project" [] object
