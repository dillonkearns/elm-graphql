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


conditions : FieldDecoder (List Object.LicenseRule) Api.Object.License
conditions =
    Field.fieldDecoder "conditions" [] (Api.Object.LicenseRule.decoder |> Decode.list)


description : FieldDecoder String Api.Object.License
description =
    Field.fieldDecoder "description" [] Decode.string


featured : FieldDecoder String Api.Object.License
featured =
    Field.fieldDecoder "featured" [] Decode.string


hidden : FieldDecoder String Api.Object.License
hidden =
    Field.fieldDecoder "hidden" [] Decode.string


id : FieldDecoder String Api.Object.License
id =
    Field.fieldDecoder "id" [] Decode.string


implementation : FieldDecoder String Api.Object.License
implementation =
    Field.fieldDecoder "implementation" [] Decode.string


key : FieldDecoder String Api.Object.License
key =
    Field.fieldDecoder "key" [] Decode.string


limitations : FieldDecoder (List Object.LicenseRule) Api.Object.License
limitations =
    Field.fieldDecoder "limitations" [] (Api.Object.LicenseRule.decoder |> Decode.list)


name : FieldDecoder String Api.Object.License
name =
    Field.fieldDecoder "name" [] Decode.string


nickname : FieldDecoder String Api.Object.License
nickname =
    Field.fieldDecoder "nickname" [] Decode.string


permissions : FieldDecoder (List Object.LicenseRule) Api.Object.License
permissions =
    Field.fieldDecoder "permissions" [] (Api.Object.LicenseRule.decoder |> Decode.list)


spdxId : FieldDecoder String Api.Object.License
spdxId =
    Field.fieldDecoder "spdxId" [] Decode.string


url : FieldDecoder String Api.Object.License
url =
    Field.fieldDecoder "url" [] Decode.string
