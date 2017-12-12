module Api.Object.DeleteProjectCardPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.DeleteProjectCardPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.DeleteProjectCardPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


column : Object column Api.Object.ProjectColumn -> FieldDecoder column Api.Object.DeleteProjectCardPayload
column object =
    Object.single "column" [] object


deletedCardId : FieldDecoder String Api.Object.DeleteProjectCardPayload
deletedCardId =
    Object.fieldDecoder "deletedCardId" [] Decode.string
