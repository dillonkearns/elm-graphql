module Api.Object.CreateProjectPayload exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.CreateProjectPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.CreateProjectPayload
clientMutationId =
    Field.fieldDecoder "clientMutationId" [] Decode.string


project : Object project Api.Object.Project -> FieldDecoder project Api.Object.CreateProjectPayload
project object =
    Object.single "project" [] object
