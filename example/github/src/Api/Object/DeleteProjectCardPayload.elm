module Api.Object.DeleteProjectCardPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Json.Decode as Decode


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
