module Api.Object.Release exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Release
build constructor =
    Object.object constructor


author : Object author Api.Object.User -> FieldDecoder author Api.Object.Release
author object =
    Object.single "author" [] object


createdAt : FieldDecoder String Api.Object.Release
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


description : FieldDecoder String Api.Object.Release
description =
    Field.fieldDecoder "description" [] Decode.string


id : FieldDecoder String Api.Object.Release
id =
    Field.fieldDecoder "id" [] Decode.string


isDraft : FieldDecoder String Api.Object.Release
isDraft =
    Field.fieldDecoder "isDraft" [] Decode.string


isPrerelease : FieldDecoder String Api.Object.Release
isPrerelease =
    Field.fieldDecoder "isPrerelease" [] Decode.string


name : FieldDecoder String Api.Object.Release
name =
    Field.fieldDecoder "name" [] Decode.string


publishedAt : FieldDecoder String Api.Object.Release
publishedAt =
    Field.fieldDecoder "publishedAt" [] Decode.string


releaseAssets : Object releaseAssets Api.Object.ReleaseAssetConnection -> FieldDecoder releaseAssets Api.Object.Release
releaseAssets object =
    Object.single "releaseAssets" [] object


resourcePath : FieldDecoder String Api.Object.Release
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


tag : Object tag Api.Object.Ref -> FieldDecoder tag Api.Object.Release
tag object =
    Object.single "tag" [] object


updatedAt : FieldDecoder String Api.Object.Release
updatedAt =
    Field.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.Release
url =
    Field.fieldDecoder "url" [] Decode.string
