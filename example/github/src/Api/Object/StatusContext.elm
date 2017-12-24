module Api.Object.StatusContext exposing (..)

import Api.Enum.StatusState
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


selection : (a -> constructor) -> Object (a -> constructor) Api.Object.StatusContext
selection constructor =
    Object.object constructor


commit : Object commit Api.Object.Commit -> FieldDecoder commit Api.Object.StatusContext
commit object =
    Object.single "commit" [] object


context : FieldDecoder String Api.Object.StatusContext
context =
    Object.fieldDecoder "context" [] Decode.string


createdAt : FieldDecoder String Api.Object.StatusContext
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


creator : Object creator Api.Object.Actor -> FieldDecoder creator Api.Object.StatusContext
creator object =
    Object.single "creator" [] object


description : FieldDecoder String Api.Object.StatusContext
description =
    Object.fieldDecoder "description" [] Decode.string


id : FieldDecoder String Api.Object.StatusContext
id =
    Object.fieldDecoder "id" [] Decode.string


state : FieldDecoder Api.Enum.StatusState.StatusState Api.Object.StatusContext
state =
    Object.fieldDecoder "state" [] Api.Enum.StatusState.decoder


targetUrl : FieldDecoder String Api.Object.StatusContext
targetUrl =
    Object.fieldDecoder "targetUrl" [] Decode.string
