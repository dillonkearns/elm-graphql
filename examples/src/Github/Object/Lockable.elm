module Github.Object.Lockable exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Lockable
selection constructor =
    Object.object constructor


{-| `true` if the object is locked
-}
locked : FieldDecoder Bool Github.Object.Lockable
locked =
    Object.fieldDecoder "locked" [] Decode.bool
