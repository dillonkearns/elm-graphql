module Api.Object.CreateProjectPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


selection : (a -> constructor) -> Object (a -> constructor) Api.Object.CreateProjectPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.CreateProjectPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


project : Object project Api.Object.Project -> FieldDecoder project Api.Object.CreateProjectPayload
project object =
    Object.single "project" [] object
