module Github.Object.CommitEdge exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.CommitEdge
selection constructor =
    Object.object constructor


cursor : FieldDecoder String Github.Object.CommitEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : SelectionSet node Github.Object.Commit -> FieldDecoder (Maybe node) Github.Object.CommitEdge
node object =
    Object.selectionFieldDecoder "node" [] object (identity >> Decode.maybe)
