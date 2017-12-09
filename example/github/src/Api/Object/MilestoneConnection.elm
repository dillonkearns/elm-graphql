module Api.Object.MilestoneConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.MilestoneConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.MilestoneEdge -> FieldDecoder (List edges) Api.Object.MilestoneConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.Milestone -> FieldDecoder (List nodes) Api.Object.MilestoneConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.MilestoneConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.MilestoneConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
