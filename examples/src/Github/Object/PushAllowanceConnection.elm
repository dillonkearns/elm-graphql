module Github.Object.PushAllowanceConnection exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.PushAllowanceConnection
selection constructor =
    Object.object constructor


edges : SelectionSet edges Github.Object.PushAllowanceEdge -> FieldDecoder (List edges) Github.Object.PushAllowanceConnection
edges object =
    Object.listOf "edges" [] object


nodes : SelectionSet nodes Github.Object.PushAllowance -> FieldDecoder (List nodes) Github.Object.PushAllowanceConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : SelectionSet pageInfo Github.Object.PageInfo -> FieldDecoder pageInfo Github.Object.PushAllowanceConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Github.Object.PushAllowanceConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
