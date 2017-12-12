module Api.Object.RepositoryTopicConnection exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RepositoryTopicConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.RepositoryTopicEdge -> FieldDecoder (List edges) Api.Object.RepositoryTopicConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.RepositoryTopic -> FieldDecoder (List nodes) Api.Object.RepositoryTopicConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.RepositoryTopicConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.RepositoryTopicConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
