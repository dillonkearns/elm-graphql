module Api.Object.IssueConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.IssueConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.IssueEdge -> FieldDecoder (List edges) Api.Object.IssueConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.Issue -> FieldDecoder (List nodes) Api.Object.IssueConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.IssueConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.IssueConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.int
