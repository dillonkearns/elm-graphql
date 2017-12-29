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


{-| A list of edges.
-}
edges : SelectionSet edges Github.Object.IssueTimelineItemEdge -> FieldDecoder (Maybe (List (Maybe edges))) Github.Object.IssueTimelineConnection
edges object =
    Object.selectionFieldDecoder "edges" [] object (identity >> Decode.maybe >> Decode.list >> Decode.maybe)


{-| A list of nodes.
-}
nodes : FieldDecoder (Maybe (List (Maybe String))) Github.Object.IssueTimelineConnection
nodes =
    Object.fieldDecoder "nodes" [] (Decode.string |> Decode.maybe |> Decode.list |> Decode.maybe)


{-| Information to aid in pagination.
-}
pageInfo : SelectionSet pageInfo Github.Object.PageInfo -> FieldDecoder pageInfo Github.Object.IssueTimelineConnection
pageInfo object =
    Object.selectionFieldDecoder "pageInfo" [] object identity


{-| Identifies the total count of items in the connection.
-}
totalCount : FieldDecoder Int Github.Object.IssueTimelineConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
