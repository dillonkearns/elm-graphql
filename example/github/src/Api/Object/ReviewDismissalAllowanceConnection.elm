module Api.Object.ReviewDismissalAllowanceConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReviewDismissalAllowanceConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.ReviewDismissalAllowanceEdge -> FieldDecoder (List edges) Api.Object.ReviewDismissalAllowanceConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.ReviewDismissalAllowance -> FieldDecoder (List nodes) Api.Object.ReviewDismissalAllowanceConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.ReviewDismissalAllowanceConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.ReviewDismissalAllowanceConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.int
