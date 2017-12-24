module Api.Object.DeployKeyConnection exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.DeployKeyConnection
selection constructor =
    Object.object constructor


edges : SelectionSet edges Api.Object.DeployKeyEdge -> FieldDecoder (List edges) Api.Object.DeployKeyConnection
edges object =
    Object.listOf "edges" [] object


nodes : SelectionSet nodes Api.Object.DeployKey -> FieldDecoder (List nodes) Api.Object.DeployKeyConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : SelectionSet pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.DeployKeyConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.DeployKeyConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
