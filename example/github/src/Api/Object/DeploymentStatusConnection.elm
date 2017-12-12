module Api.Object.DeploymentStatusConnection exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.DeploymentStatusConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.DeploymentStatusEdge -> FieldDecoder (List edges) Api.Object.DeploymentStatusConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.DeploymentStatus -> FieldDecoder (List nodes) Api.Object.DeploymentStatusConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.DeploymentStatusConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.DeploymentStatusConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
