module Github.Object.ExternalIdentitySamlAttributes exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ExternalIdentitySamlAttributes
selection constructor =
    Object.object constructor


nameId : FieldDecoder String Github.Object.ExternalIdentitySamlAttributes
nameId =
    Object.fieldDecoder "nameId" [] Decode.string
