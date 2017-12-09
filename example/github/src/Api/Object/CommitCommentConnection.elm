module Api.Object.CommitCommentConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.CommitCommentConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.CommitCommentEdge -> FieldDecoder (List edges) Api.Object.CommitCommentConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.CommitComment -> FieldDecoder (List nodes) Api.Object.CommitCommentConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.CommitCommentConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.CommitCommentConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
