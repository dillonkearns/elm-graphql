module Github.Object.TeamRepositoryConnection exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.TeamRepositoryConnection
selection constructor =
    Object.object constructor


edges : SelectionSet edges Github.Object.TeamRepositoryEdge -> FieldDecoder (List edges) Github.Object.TeamRepositoryConnection
edges object =
    Object.listOf "edges" [] object


nodes : SelectionSet nodes Github.Object.Repository -> FieldDecoder (List nodes) Github.Object.TeamRepositoryConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : SelectionSet pageInfo Github.Object.PageInfo -> FieldDecoder pageInfo Github.Object.TeamRepositoryConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Github.Object.TeamRepositoryConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
