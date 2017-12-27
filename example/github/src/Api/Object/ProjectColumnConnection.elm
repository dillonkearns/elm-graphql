module Api.Object.ProjectColumnConnection exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.ProjectColumnConnection
selection constructor =
    Object.object constructor


edges : SelectionSet edges Api.Object.ProjectColumnEdge -> FieldDecoder (List edges) Api.Object.ProjectColumnConnection
edges object =
    Object.listOf "edges" [] object


nodes : SelectionSet nodes Api.Object.ProjectColumn -> FieldDecoder (List nodes) Api.Object.ProjectColumnConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : SelectionSet pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.ProjectColumnConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.ProjectColumnConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
