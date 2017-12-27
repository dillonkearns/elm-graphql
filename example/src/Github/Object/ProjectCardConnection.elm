module Github.Object.ProjectCardConnection exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ProjectCardConnection
selection constructor =
    Object.object constructor


edges : SelectionSet edges Github.Object.ProjectCardEdge -> FieldDecoder (List edges) Github.Object.ProjectCardConnection
edges object =
    Object.listOf "edges" [] object


nodes : SelectionSet nodes Github.Object.ProjectCard -> FieldDecoder (List nodes) Github.Object.ProjectCardConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : SelectionSet pageInfo Github.Object.PageInfo -> FieldDecoder pageInfo Github.Object.ProjectCardConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Github.Object.ProjectCardConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
