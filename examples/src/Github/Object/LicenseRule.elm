module Github.Object.LicenseRule exposing (..)

import Github.Interface
import Github.Object
import Github.Union
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


{-| Select fields to build up a SelectionSet for this object.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.LicenseRule
selection constructor =
    Object.object constructor


{-| A description of the rule
-}
description : FieldDecoder String Github.Object.LicenseRule
description =
    Object.fieldDecoder "description" [] Decode.string


{-| The machine-readable rule key
-}
key : FieldDecoder String Github.Object.LicenseRule
key =
    Object.fieldDecoder "key" [] Decode.string


{-| The human-readable rule label
-}
label : FieldDecoder String Github.Object.LicenseRule
label =
    Object.fieldDecoder "label" [] Decode.string
