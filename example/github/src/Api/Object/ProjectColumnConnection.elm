module Api.Object.ProjectColumnConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ProjectColumnConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.ProjectColumnEdge -> FieldDecoder (List edges) Api.Object.ProjectColumnConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.ProjectColumn -> FieldDecoder (List nodes) Api.Object.ProjectColumnConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.ProjectColumnConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.ProjectColumnConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
