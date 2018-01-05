module Github.Object.StargazerEdge exposing (..)

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
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.StargazerEdge
selection constructor =
    Object.object constructor


cursor : FieldDecoder String Github.Object.StargazerEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : SelectionSet selection Github.Object.User -> FieldDecoder selection Github.Object.StargazerEdge
node object =
    Object.selectionFieldDecoder "node" [] object identity


{-| Identifies when the item was starred.
-}
starredAt : FieldDecoder String Github.Object.StargazerEdge
starredAt =
    Object.fieldDecoder "starredAt" [] Decode.string
