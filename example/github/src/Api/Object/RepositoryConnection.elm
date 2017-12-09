module Api.Object.RepositoryConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


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
