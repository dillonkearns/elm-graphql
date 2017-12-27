module Github.Object.FollowerConnection exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.FollowerConnection
selection constructor =
    Object.object constructor


edges : SelectionSet edges Github.Object.UserEdge -> FieldDecoder (List edges) Github.Object.FollowerConnection
edges object =
    Object.listOf "edges" [] object


nodes : SelectionSet nodes Github.Object.User -> FieldDecoder (List nodes) Github.Object.FollowerConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : SelectionSet pageInfo Github.Object.PageInfo -> FieldDecoder pageInfo Github.Object.FollowerConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Github.Object.FollowerConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
