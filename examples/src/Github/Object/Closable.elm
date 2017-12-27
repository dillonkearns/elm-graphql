module Github.Object.Closable exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Closable
selection constructor =
    Object.object constructor


closed : FieldDecoder Bool Github.Object.Closable
closed =
    Object.fieldDecoder "closed" [] Decode.bool


closedAt : FieldDecoder String Github.Object.Closable
closedAt =
    Object.fieldDecoder "closedAt" [] Decode.string
