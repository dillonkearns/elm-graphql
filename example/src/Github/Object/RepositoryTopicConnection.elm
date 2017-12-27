module Github.Object.RepositoryTopicConnection exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.RepositoryTopicConnection
selection constructor =
    Object.object constructor


edges : SelectionSet edges Github.Object.RepositoryTopicEdge -> FieldDecoder (List edges) Github.Object.RepositoryTopicConnection
edges object =
    Object.listOf "edges" [] object


nodes : SelectionSet nodes Github.Object.RepositoryTopic -> FieldDecoder (List nodes) Github.Object.RepositoryTopicConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : SelectionSet pageInfo Github.Object.PageInfo -> FieldDecoder pageInfo Github.Object.RepositoryTopicConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Github.Object.RepositoryTopicConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
