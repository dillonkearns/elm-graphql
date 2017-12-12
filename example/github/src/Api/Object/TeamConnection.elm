module Api.Object.TeamConnection exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.TeamConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.TeamEdge -> FieldDecoder (List edges) Api.Object.TeamConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.Team -> FieldDecoder (List nodes) Api.Object.TeamConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.TeamConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.TeamConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
