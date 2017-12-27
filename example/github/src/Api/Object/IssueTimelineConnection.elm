module Api.Object.IssueTimelineConnection exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.IssueTimelineConnection
selection constructor =
    Object.object constructor


edges : SelectionSet edges Api.Object.IssueTimelineItemEdge -> FieldDecoder (List edges) Api.Object.IssueTimelineConnection
edges object =
    Object.listOf "edges" [] object


nodes : FieldDecoder (List String) Api.Object.IssueTimelineConnection
nodes =
    Object.fieldDecoder "nodes" [] (Decode.string |> Decode.list)


pageInfo : SelectionSet pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.IssueTimelineConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.IssueTimelineConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
