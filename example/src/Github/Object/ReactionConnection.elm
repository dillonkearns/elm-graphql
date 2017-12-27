module Github.Object.ReactionConnection exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ReactionConnection
selection constructor =
    Object.object constructor


edges : SelectionSet edges Github.Object.ReactionEdge -> FieldDecoder (List edges) Github.Object.ReactionConnection
edges object =
    Object.listOf "edges" [] object


nodes : SelectionSet nodes Github.Object.Reaction -> FieldDecoder (List nodes) Github.Object.ReactionConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : SelectionSet pageInfo Github.Object.PageInfo -> FieldDecoder pageInfo Github.Object.ReactionConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Github.Object.ReactionConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int


viewerHasReacted : FieldDecoder Bool Github.Object.ReactionConnection
viewerHasReacted =
    Object.fieldDecoder "viewerHasReacted" [] Decode.bool
