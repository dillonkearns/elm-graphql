module Api.Object.ProtectedBranchConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ProtectedBranchConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.ProtectedBranchEdge -> FieldDecoder (List edges) Api.Object.ProtectedBranchConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.ProtectedBranch -> FieldDecoder (List nodes) Api.Object.ProtectedBranchConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.ProtectedBranchConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.ProtectedBranchConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.int
