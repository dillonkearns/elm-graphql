module Api.Object.RepositoryConnection exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RepositoryConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.RepositoryEdge -> FieldDecoder (List edges) Api.Object.RepositoryConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.Repository -> FieldDecoder (List nodes) Api.Object.RepositoryConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.RepositoryConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.RepositoryConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int


totalDiskUsage : FieldDecoder Int Api.Object.RepositoryConnection
totalDiskUsage =
    Object.fieldDecoder "totalDiskUsage" [] Decode.int
