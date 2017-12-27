module Github.Object.ReleaseAsset exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ReleaseAsset
selection constructor =
    Object.object constructor


contentType : FieldDecoder String Github.Object.ReleaseAsset
contentType =
    Object.fieldDecoder "contentType" [] Decode.string


createdAt : FieldDecoder String Github.Object.ReleaseAsset
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


downloadCount : FieldDecoder Int Github.Object.ReleaseAsset
downloadCount =
    Object.fieldDecoder "downloadCount" [] Decode.int


downloadUrl : FieldDecoder String Github.Object.ReleaseAsset
downloadUrl =
    Object.fieldDecoder "downloadUrl" [] Decode.string


id : FieldDecoder String Github.Object.ReleaseAsset
id =
    Object.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Github.Object.ReleaseAsset
name =
    Object.fieldDecoder "name" [] Decode.string


release : SelectionSet release Github.Object.Release -> FieldDecoder release Github.Object.ReleaseAsset
release object =
    Object.single "release" [] object


size : FieldDecoder Int Github.Object.ReleaseAsset
size =
    Object.fieldDecoder "size" [] Decode.int


updatedAt : FieldDecoder String Github.Object.ReleaseAsset
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


uploadedBy : SelectionSet uploadedBy Github.Object.User -> FieldDecoder uploadedBy Github.Object.ReleaseAsset
uploadedBy object =
    Object.single "uploadedBy" [] object


url : FieldDecoder String Github.Object.ReleaseAsset
url =
    Object.fieldDecoder "url" [] Decode.string
