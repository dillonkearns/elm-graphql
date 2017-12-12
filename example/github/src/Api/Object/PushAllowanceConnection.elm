module Api.Object.PushAllowanceConnection exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PushAllowanceConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.PushAllowanceEdge -> FieldDecoder (List edges) Api.Object.PushAllowanceConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.PushAllowance -> FieldDecoder (List nodes) Api.Object.PushAllowanceConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.PushAllowanceConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.PushAllowanceConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
