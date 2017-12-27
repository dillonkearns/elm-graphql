module Github.Object.License exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.License
selection constructor =
    Object.object constructor


body : FieldDecoder String Github.Object.License
body =
    Object.fieldDecoder "body" [] Decode.string


conditions : SelectionSet conditions Github.Object.LicenseRule -> FieldDecoder (List conditions) Github.Object.License
conditions object =
    Object.listOf "conditions" [] object


description : FieldDecoder String Github.Object.License
description =
    Object.fieldDecoder "description" [] Decode.string


featured : FieldDecoder Bool Github.Object.License
featured =
    Object.fieldDecoder "featured" [] Decode.bool


hidden : FieldDecoder Bool Github.Object.License
hidden =
    Object.fieldDecoder "hidden" [] Decode.bool


id : FieldDecoder String Github.Object.License
id =
    Object.fieldDecoder "id" [] Decode.string


implementation : FieldDecoder String Github.Object.License
implementation =
    Object.fieldDecoder "implementation" [] Decode.string


key : FieldDecoder String Github.Object.License
key =
    Object.fieldDecoder "key" [] Decode.string


limitations : SelectionSet limitations Github.Object.LicenseRule -> FieldDecoder (List limitations) Github.Object.License
limitations object =
    Object.listOf "limitations" [] object


name : FieldDecoder String Github.Object.License
name =
    Object.fieldDecoder "name" [] Decode.string


nickname : FieldDecoder String Github.Object.License
nickname =
    Object.fieldDecoder "nickname" [] Decode.string


permissions : SelectionSet permissions Github.Object.LicenseRule -> FieldDecoder (List permissions) Github.Object.License
permissions object =
    Object.listOf "permissions" [] object


spdxId : FieldDecoder String Github.Object.License
spdxId =
    Object.fieldDecoder "spdxId" [] Decode.string


url : FieldDecoder String Github.Object.License
url =
    Object.fieldDecoder "url" [] Decode.string
