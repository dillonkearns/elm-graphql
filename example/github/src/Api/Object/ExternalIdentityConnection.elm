module Api.Object.ExternalIdentityConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ExternalIdentityConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.ExternalIdentityEdge -> FieldDecoder (List edges) Api.Object.ExternalIdentityConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.ExternalIdentity -> FieldDecoder (List nodes) Api.Object.ExternalIdentityConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.ExternalIdentityConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.ExternalIdentityConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
