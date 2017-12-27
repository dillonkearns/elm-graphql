module Github.Object.LicenseRule exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.LicenseRule
selection constructor =
    Object.object constructor


description : FieldDecoder String Github.Object.LicenseRule
description =
    Object.fieldDecoder "description" [] Decode.string


key : FieldDecoder String Github.Object.LicenseRule
key =
    Object.fieldDecoder "key" [] Decode.string


label : FieldDecoder String Github.Object.LicenseRule
label =
    Object.fieldDecoder "label" [] Decode.string
