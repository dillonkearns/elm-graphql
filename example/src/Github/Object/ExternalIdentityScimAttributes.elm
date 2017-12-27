module Github.Object.ExternalIdentityScimAttributes exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ExternalIdentityScimAttributes
selection constructor =
    Object.object constructor


username : FieldDecoder String Github.Object.ExternalIdentityScimAttributes
username =
    Object.fieldDecoder "username" [] Decode.string
