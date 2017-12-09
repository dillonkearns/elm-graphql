module Api.Object.FollowingConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.FollowingConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.UserEdge -> FieldDecoder (List edges) Api.Object.FollowingConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.User -> FieldDecoder (List nodes) Api.Object.FollowingConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.FollowingConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.FollowingConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
