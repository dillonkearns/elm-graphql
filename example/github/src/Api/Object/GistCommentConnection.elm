module Api.Object.GistCommentConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.GistCommentConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.GistCommentEdge -> FieldDecoder (List edges) Api.Object.GistCommentConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.GistComment -> FieldDecoder (List nodes) Api.Object.GistCommentConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.GistCommentConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.GistCommentConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
