module Api.Object.ReleaseAsset exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReleaseAsset
build constructor =
    Object.object constructor


contentType : FieldDecoder String Api.Object.ReleaseAsset
contentType =
    Field.fieldDecoder "contentType" [] Decode.string


createdAt : FieldDecoder String Api.Object.ReleaseAsset
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


downloadCount : FieldDecoder Int Api.Object.ReleaseAsset
downloadCount =
    Field.fieldDecoder "downloadCount" [] Decode.int


downloadUrl : FieldDecoder String Api.Object.ReleaseAsset
downloadUrl =
    Field.fieldDecoder "downloadUrl" [] Decode.string


id : FieldDecoder String Api.Object.ReleaseAsset
id =
    Field.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Api.Object.ReleaseAsset
name =
    Field.fieldDecoder "name" [] Decode.string


release : Object release Api.Object.Release -> FieldDecoder release Api.Object.ReleaseAsset
release object =
    Object.single "release" [] object


size : FieldDecoder Int Api.Object.ReleaseAsset
size =
    Field.fieldDecoder "size" [] Decode.int


updatedAt : FieldDecoder String Api.Object.ReleaseAsset
updatedAt =
    Field.fieldDecoder "updatedAt" [] Decode.string


uploadedBy : Object uploadedBy Api.Object.User -> FieldDecoder uploadedBy Api.Object.ReleaseAsset
uploadedBy object =
    Object.single "uploadedBy" [] object


url : FieldDecoder String Api.Object.ReleaseAsset
url =
    Field.fieldDecoder "url" [] Decode.string
