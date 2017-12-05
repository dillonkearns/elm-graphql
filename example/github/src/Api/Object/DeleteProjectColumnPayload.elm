module Api.Object.DeleteProjectColumnPayload exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.DeleteProjectColumnPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.DeleteProjectColumnPayload
clientMutationId =
    Field.fieldDecoder "clientMutationId" [] Decode.string


deletedColumnId : FieldDecoder String Api.Object.DeleteProjectColumnPayload
deletedColumnId =
    Field.fieldDecoder "deletedColumnId" [] Decode.string


project : Object project Api.Object.Project -> FieldDecoder project Api.Object.DeleteProjectColumnPayload
project object =
    Object.single "project" [] object
