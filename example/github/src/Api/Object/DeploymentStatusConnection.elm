module Api.Object.DeploymentStatusConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


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
