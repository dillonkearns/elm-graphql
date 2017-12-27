module Github.Object.IssueTimelineConnection exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.IssueTimelineConnection
selection constructor =
    Object.object constructor


edges : SelectionSet edges Github.Object.IssueTimelineItemEdge -> FieldDecoder (List edges) Github.Object.IssueTimelineConnection
edges object =
    Object.listOf "edges" [] object


nodes : FieldDecoder (List String) Github.Object.IssueTimelineConnection
nodes =
    Object.fieldDecoder "nodes" [] (Decode.string |> Decode.list)


pageInfo : SelectionSet pageInfo Github.Object.PageInfo -> FieldDecoder pageInfo Github.Object.IssueTimelineConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Github.Object.IssueTimelineConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
