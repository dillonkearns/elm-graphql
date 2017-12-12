module Api.Object.OrganizationConnection exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
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
    Object.fieldDecoder "totalCount" [] Decode.int
