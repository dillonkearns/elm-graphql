module Api.Object.PullRequestReviewCommentConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PullRequestReviewCommentConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.PullRequestReviewCommentEdge -> FieldDecoder (List edges) Api.Object.PullRequestReviewCommentConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.PullRequestReviewComment -> FieldDecoder (List nodes) Api.Object.PullRequestReviewCommentConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.PullRequestReviewCommentConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.PullRequestReviewCommentConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
