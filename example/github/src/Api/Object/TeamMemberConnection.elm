module Api.Object.TeamMemberConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.TeamMemberConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.TeamMemberEdge -> FieldDecoder (List edges) Api.Object.TeamMemberConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.User -> FieldDecoder (List nodes) Api.Object.TeamMemberConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.TeamMemberConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.TeamMemberConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
