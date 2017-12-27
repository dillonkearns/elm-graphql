module Api.Object.License exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.License
selection constructor =
    Object.object constructor


body : FieldDecoder String Api.Object.License
body =
    Object.fieldDecoder "body" [] Decode.string


conditions : SelectionSet conditions Api.Object.LicenseRule -> FieldDecoder (List conditions) Api.Object.License
conditions object =
    Object.listOf "conditions" [] object


description : FieldDecoder String Api.Object.License
description =
    Object.fieldDecoder "description" [] Decode.string


featured : FieldDecoder Bool Api.Object.License
featured =
    Object.fieldDecoder "featured" [] Decode.bool


hidden : FieldDecoder Bool Api.Object.License
hidden =
    Object.fieldDecoder "hidden" [] Decode.bool


id : FieldDecoder String Api.Object.License
id =
    Object.fieldDecoder "id" [] Decode.string


implementation : FieldDecoder String Api.Object.License
implementation =
    Object.fieldDecoder "implementation" [] Decode.string


key : FieldDecoder String Api.Object.License
key =
    Object.fieldDecoder "key" [] Decode.string


limitations : SelectionSet limitations Api.Object.LicenseRule -> FieldDecoder (List limitations) Api.Object.License
limitations object =
    Object.listOf "limitations" [] object


name : FieldDecoder String Api.Object.License
name =
    Object.fieldDecoder "name" [] Decode.string


nickname : FieldDecoder String Api.Object.License
nickname =
    Object.fieldDecoder "nickname" [] Decode.string


permissions : SelectionSet permissions Api.Object.LicenseRule -> FieldDecoder (List permissions) Api.Object.License
permissions object =
    Object.listOf "permissions" [] object


spdxId : FieldDecoder String Api.Object.License
spdxId =
    Object.fieldDecoder "spdxId" [] Decode.string


url : FieldDecoder String Api.Object.License
url =
    Object.fieldDecoder "url" [] Decode.string
