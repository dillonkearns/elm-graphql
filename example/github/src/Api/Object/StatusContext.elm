module Api.Object.StatusContext exposing (..)

import Api.Enum.StatusState
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.StatusContext
build constructor =
    Object.object constructor


commit : Object commit Api.Object.Commit -> FieldDecoder commit Api.Object.StatusContext
commit object =
    Object.single "commit" [] object


context : FieldDecoder String Api.Object.StatusContext
context =
    Field.fieldDecoder "context" [] Decode.string


createdAt : FieldDecoder String Api.Object.StatusContext
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


creator : Object creator Api.Object.Actor -> FieldDecoder creator Api.Object.StatusContext
creator object =
    Object.single "creator" [] object


description : FieldDecoder String Api.Object.StatusContext
description =
    Field.fieldDecoder "description" [] Decode.string


id : FieldDecoder String Api.Object.StatusContext
id =
    Field.fieldDecoder "id" [] Decode.string


state : FieldDecoder Api.Enum.StatusState.StatusState Api.Object.StatusContext
state =
    Field.fieldDecoder "state" [] Api.Enum.StatusState.decoder


targetUrl : FieldDecoder String Api.Object.StatusContext
targetUrl =
    Field.fieldDecoder "targetUrl" [] Decode.string
