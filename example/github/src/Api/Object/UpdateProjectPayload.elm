module Api.Object.UpdateProjectPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.UpdateProjectPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.UpdateProjectPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


project : Object project Api.Object.Project -> FieldDecoder project Api.Object.UpdateProjectPayload
project object =
    Object.single "project" [] object
