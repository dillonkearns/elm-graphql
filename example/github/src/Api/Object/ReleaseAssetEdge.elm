module Api.Object.ReleaseAssetEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.ReleaseAssetEdge
selection constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.ReleaseAssetEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : SelectionSet node Api.Object.ReleaseAsset -> FieldDecoder node Api.Object.ReleaseAssetEdge
node object =
    Object.single "node" [] object
