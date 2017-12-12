module Api.Object.ReleaseAssetEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReleaseAssetEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.ReleaseAssetEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.ReleaseAsset -> FieldDecoder node Api.Object.ReleaseAssetEdge
node object =
    Object.single "node" [] object
