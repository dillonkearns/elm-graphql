module Api.Object.CreateProjectPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.CreateProjectPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.CreateProjectPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


project : Object project Api.Object.Project -> FieldDecoder project Api.Object.CreateProjectPayload
project object =
    Object.single "project" [] object
