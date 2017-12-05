module Api.Object.OrganizationConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.OrganizationConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.OrganizationEdge -> FieldDecoder (List edges) Api.Object.OrganizationConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.Organization -> FieldDecoder (List nodes) Api.Object.OrganizationConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.OrganizationConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.OrganizationConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.int
