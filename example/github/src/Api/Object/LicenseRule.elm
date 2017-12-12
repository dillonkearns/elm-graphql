module Api.Object.LicenseRule exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.LicenseRule
build constructor =
    Object.object constructor


description : FieldDecoder String Api.Object.LicenseRule
description =
    Object.fieldDecoder "description" [] Decode.string


key : FieldDecoder String Api.Object.LicenseRule
key =
    Object.fieldDecoder "key" [] Decode.string


label : FieldDecoder String Api.Object.LicenseRule
label =
    Object.fieldDecoder "label" [] Decode.string
