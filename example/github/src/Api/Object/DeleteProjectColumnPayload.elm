module Api.Object.DeleteProjectColumnPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.DeleteProjectColumnPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.DeleteProjectColumnPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


deletedColumnId : FieldDecoder String Api.Object.DeleteProjectColumnPayload
deletedColumnId =
    Object.fieldDecoder "deletedColumnId" [] Decode.string


project : Object project Api.Object.Project -> FieldDecoder project Api.Object.DeleteProjectColumnPayload
project object =
    Object.single "project" [] object
