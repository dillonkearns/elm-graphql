module Api.Object.PullRequestCommitConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PullRequestCommitConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.PullRequestCommitEdge -> FieldDecoder (List edges) Api.Object.PullRequestCommitConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.PullRequestCommit -> FieldDecoder (List nodes) Api.Object.PullRequestCommitConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.PullRequestCommitConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.PullRequestCommitConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
