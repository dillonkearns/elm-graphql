module Api.Object.IssueCommentConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.IssueCommentConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.IssueCommentEdge -> FieldDecoder (List edges) Api.Object.IssueCommentConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.IssueComment -> FieldDecoder (List nodes) Api.Object.IssueCommentConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.IssueCommentConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.IssueCommentConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.int
