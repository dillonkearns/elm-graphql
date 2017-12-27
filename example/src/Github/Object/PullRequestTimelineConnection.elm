module Github.Object.PullRequestTimelineConnection exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.PullRequestTimelineConnection
selection constructor =
    Object.object constructor


edges : SelectionSet edges Github.Object.PullRequestTimelineItemEdge -> FieldDecoder (List edges) Github.Object.PullRequestTimelineConnection
edges object =
    Object.listOf "edges" [] object


nodes : FieldDecoder (List String) Github.Object.PullRequestTimelineConnection
nodes =
    Object.fieldDecoder "nodes" [] (Decode.string |> Decode.list)


pageInfo : SelectionSet pageInfo Github.Object.PageInfo -> FieldDecoder pageInfo Github.Object.PullRequestTimelineConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Github.Object.PullRequestTimelineConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
