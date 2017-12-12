module Api.Object.DeployKeyConnection exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.DeployKeyConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.DeployKeyEdge -> FieldDecoder (List edges) Api.Object.DeployKeyConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.DeployKey -> FieldDecoder (List nodes) Api.Object.DeployKeyConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.DeployKeyConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.DeployKeyConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
