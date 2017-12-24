module Api.Object.Release exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.Release
selection constructor =
    Object.object constructor


author : SelectionSet author Api.Object.User -> FieldDecoder author Api.Object.Release
author object =
    Object.single "author" [] object


createdAt : FieldDecoder String Api.Object.Release
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


description : FieldDecoder String Api.Object.Release
description =
    Object.fieldDecoder "description" [] Decode.string


id : FieldDecoder String Api.Object.Release
id =
    Object.fieldDecoder "id" [] Decode.string


isDraft : FieldDecoder Bool Api.Object.Release
isDraft =
    Object.fieldDecoder "isDraft" [] Decode.bool


isPrerelease : FieldDecoder Bool Api.Object.Release
isPrerelease =
    Object.fieldDecoder "isPrerelease" [] Decode.bool


name : FieldDecoder String Api.Object.Release
name =
    Object.fieldDecoder "name" [] Decode.string


publishedAt : FieldDecoder String Api.Object.Release
publishedAt =
    Object.fieldDecoder "publishedAt" [] Decode.string


releaseAssets : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, name : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, name : Maybe String }) -> SelectionSet releaseAssets Api.Object.ReleaseAssetConnection -> FieldDecoder releaseAssets Api.Object.Release
releaseAssets fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, name = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "name" filledInOptionals.name Encode.string ]
                |> List.filterMap identity
    in
    Object.single "releaseAssets" optionalArgs object


resourcePath : FieldDecoder String Api.Object.Release
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


tag : SelectionSet tag Api.Object.Ref -> FieldDecoder tag Api.Object.Release
tag object =
    Object.single "tag" [] object


updatedAt : FieldDecoder String Api.Object.Release
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.Release
url =
    Object.fieldDecoder "url" [] Decode.string
