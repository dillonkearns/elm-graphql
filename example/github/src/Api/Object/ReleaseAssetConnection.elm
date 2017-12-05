module Api.Object.ReleaseAssetConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReleaseAssetConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.ReleaseAssetEdge) Api.Object.ReleaseAssetConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.ReleaseAssetEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.ReleaseAsset) Api.Object.ReleaseAssetConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.ReleaseAsset.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.ReleaseAssetConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.ReleaseAssetConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
