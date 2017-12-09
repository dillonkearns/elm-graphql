module Api.Object.ReleaseAsset exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReleaseAsset
build constructor =
    Object.object constructor


contentType : FieldDecoder String Api.Object.ReleaseAsset
contentType =
    Object.fieldDecoder "contentType" [] Decode.string


createdAt : FieldDecoder String Api.Object.ReleaseAsset
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


downloadCount : FieldDecoder Int Api.Object.ReleaseAsset
downloadCount =
    Object.fieldDecoder "downloadCount" [] Decode.int


downloadUrl : FieldDecoder String Api.Object.ReleaseAsset
downloadUrl =
    Object.fieldDecoder "downloadUrl" [] Decode.string


id : FieldDecoder String Api.Object.ReleaseAsset
id =
    Object.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Api.Object.ReleaseAsset
name =
    Object.fieldDecoder "name" [] Decode.string


release : Object release Api.Object.Release -> FieldDecoder release Api.Object.ReleaseAsset
release object =
    Object.single "release" [] object


size : FieldDecoder Int Api.Object.ReleaseAsset
size =
    Object.fieldDecoder "size" [] Decode.int


updatedAt : FieldDecoder String Api.Object.ReleaseAsset
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


uploadedBy : Object uploadedBy Api.Object.User -> FieldDecoder uploadedBy Api.Object.ReleaseAsset
uploadedBy object =
    Object.single "uploadedBy" [] object


url : FieldDecoder String Api.Object.ReleaseAsset
url =
    Object.fieldDecoder "url" [] Decode.string
