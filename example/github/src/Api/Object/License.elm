module Api.Object.License exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.License
build constructor =
    Object.object constructor


body : FieldDecoder String Api.Object.License
body =
    Field.fieldDecoder "body" [] Decode.string


conditions : Object conditions Api.Object.LicenseRule -> FieldDecoder (List conditions) Api.Object.License
conditions object =
    Object.listOf "conditions" [] object


description : FieldDecoder String Api.Object.License
description =
    Field.fieldDecoder "description" [] Decode.string


featured : FieldDecoder Bool Api.Object.License
featured =
    Field.fieldDecoder "featured" [] Decode.bool


hidden : FieldDecoder Bool Api.Object.License
hidden =
    Field.fieldDecoder "hidden" [] Decode.bool


id : FieldDecoder String Api.Object.License
id =
    Field.fieldDecoder "id" [] Decode.string


implementation : FieldDecoder String Api.Object.License
implementation =
    Field.fieldDecoder "implementation" [] Decode.string


key : FieldDecoder String Api.Object.License
key =
    Field.fieldDecoder "key" [] Decode.string


limitations : Object limitations Api.Object.LicenseRule -> FieldDecoder (List limitations) Api.Object.License
limitations object =
    Object.listOf "limitations" [] object


name : FieldDecoder String Api.Object.License
name =
    Field.fieldDecoder "name" [] Decode.string


nickname : FieldDecoder String Api.Object.License
nickname =
    Field.fieldDecoder "nickname" [] Decode.string


permissions : Object permissions Api.Object.LicenseRule -> FieldDecoder (List permissions) Api.Object.License
permissions object =
    Object.listOf "permissions" [] object


spdxId : FieldDecoder String Api.Object.License
spdxId =
    Field.fieldDecoder "spdxId" [] Decode.string


url : FieldDecoder String Api.Object.License
url =
    Field.fieldDecoder "url" [] Decode.string
