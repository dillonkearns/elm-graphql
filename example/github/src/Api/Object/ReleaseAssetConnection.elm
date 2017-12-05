module Api.Object.ReleaseAssetConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReleaseAssetConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.ReleaseAssetEdge -> FieldDecoder (List edges) Api.Object.ReleaseAssetConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.ReleaseAsset -> FieldDecoder (List nodes) Api.Object.ReleaseAssetConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.ReleaseAssetConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.ReleaseAssetConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.int
