module Api.Object.LicenseRule exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.LicenseRule
build constructor =
    Object.object constructor


description : FieldDecoder String Api.Object.LicenseRule
description =
    Field.fieldDecoder "description" [] Decode.string


key : FieldDecoder String Api.Object.LicenseRule
key =
    Field.fieldDecoder "key" [] Decode.string


label : FieldDecoder String Api.Object.LicenseRule
label =
    Field.fieldDecoder "label" [] Decode.string
