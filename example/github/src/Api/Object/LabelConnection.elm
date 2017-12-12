module Api.Object.LabelConnection exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.LabelConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.LabelEdge -> FieldDecoder (List edges) Api.Object.LabelConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.Label -> FieldDecoder (List nodes) Api.Object.LabelConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.LabelConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.LabelConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
