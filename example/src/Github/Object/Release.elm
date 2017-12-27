module Github.Object.Release exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Release
selection constructor =
    Object.object constructor


author : SelectionSet author Github.Object.User -> FieldDecoder author Github.Object.Release
author object =
    Object.single "author" [] object


createdAt : FieldDecoder String Github.Object.Release
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


description : FieldDecoder String Github.Object.Release
description =
    Object.fieldDecoder "description" [] Decode.string


id : FieldDecoder String Github.Object.Release
id =
    Object.fieldDecoder "id" [] Decode.string


isDraft : FieldDecoder Bool Github.Object.Release
isDraft =
    Object.fieldDecoder "isDraft" [] Decode.bool


isPrerelease : FieldDecoder Bool Github.Object.Release
isPrerelease =
    Object.fieldDecoder "isPrerelease" [] Decode.bool


name : FieldDecoder String Github.Object.Release
name =
    Object.fieldDecoder "name" [] Decode.string


publishedAt : FieldDecoder String Github.Object.Release
publishedAt =
    Object.fieldDecoder "publishedAt" [] Decode.string


releaseAssets : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, name : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, name : OptionalArgument String }) -> SelectionSet releaseAssets Github.Object.ReleaseAssetConnection -> FieldDecoder releaseAssets Github.Object.Release
releaseAssets fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, name = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "name" filledInOptionals.name Encode.string ]
                |> List.filterMap identity
    in
    Object.single "releaseAssets" optionalArgs object


resourcePath : FieldDecoder String Github.Object.Release
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


tag : SelectionSet tag Github.Object.Ref -> FieldDecoder tag Github.Object.Release
tag object =
    Object.single "tag" [] object


updatedAt : FieldDecoder String Github.Object.Release
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Github.Object.Release
url =
    Object.fieldDecoder "url" [] Decode.string
