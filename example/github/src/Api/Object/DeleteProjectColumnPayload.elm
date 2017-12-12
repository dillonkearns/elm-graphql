module Api.Object.DeleteProjectColumnPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


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
