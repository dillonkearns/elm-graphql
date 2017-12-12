module Api.Object.DeployKey exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.DeployKey
build constructor =
    Object.object constructor


createdAt : FieldDecoder String Api.Object.DeployKey
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Api.Object.DeployKey
id =
    Object.fieldDecoder "id" [] Decode.string


key : FieldDecoder String Api.Object.DeployKey
key =
    Object.fieldDecoder "key" [] Decode.string


readOnly : FieldDecoder Bool Api.Object.DeployKey
readOnly =
    Object.fieldDecoder "readOnly" [] Decode.bool


title : FieldDecoder String Api.Object.DeployKey
title =
    Object.fieldDecoder "title" [] Decode.string


verified : FieldDecoder Bool Api.Object.DeployKey
verified =
    Object.fieldDecoder "verified" [] Decode.bool
