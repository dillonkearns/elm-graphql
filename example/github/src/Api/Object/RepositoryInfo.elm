module Api.Object.RepositoryInfo exposing (..)

import Api.Enum.RepositoryLockReason
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RepositoryInfo
build constructor =
    Object.object constructor


createdAt : FieldDecoder String Api.Object.RepositoryInfo
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


description : FieldDecoder String Api.Object.RepositoryInfo
description =
    Object.fieldDecoder "description" [] Decode.string


descriptionHTML : FieldDecoder String Api.Object.RepositoryInfo
descriptionHTML =
    Object.fieldDecoder "descriptionHTML" [] Decode.string


forkCount : FieldDecoder Int Api.Object.RepositoryInfo
forkCount =
    Object.fieldDecoder "forkCount" [] Decode.int


hasIssuesEnabled : FieldDecoder Bool Api.Object.RepositoryInfo
hasIssuesEnabled =
    Object.fieldDecoder "hasIssuesEnabled" [] Decode.bool


hasWikiEnabled : FieldDecoder Bool Api.Object.RepositoryInfo
hasWikiEnabled =
    Object.fieldDecoder "hasWikiEnabled" [] Decode.bool


homepageUrl : FieldDecoder String Api.Object.RepositoryInfo
homepageUrl =
    Object.fieldDecoder "homepageUrl" [] Decode.string


isArchived : FieldDecoder Bool Api.Object.RepositoryInfo
isArchived =
    Object.fieldDecoder "isArchived" [] Decode.bool


isFork : FieldDecoder Bool Api.Object.RepositoryInfo
isFork =
    Object.fieldDecoder "isFork" [] Decode.bool


isLocked : FieldDecoder Bool Api.Object.RepositoryInfo
isLocked =
    Object.fieldDecoder "isLocked" [] Decode.bool


isMirror : FieldDecoder Bool Api.Object.RepositoryInfo
isMirror =
    Object.fieldDecoder "isMirror" [] Decode.bool


isPrivate : FieldDecoder Bool Api.Object.RepositoryInfo
isPrivate =
    Object.fieldDecoder "isPrivate" [] Decode.bool


license : FieldDecoder String Api.Object.RepositoryInfo
license =
    Object.fieldDecoder "license" [] Decode.string


licenseInfo : Object licenseInfo Api.Object.License -> FieldDecoder licenseInfo Api.Object.RepositoryInfo
licenseInfo object =
    Object.single "licenseInfo" [] object


lockReason : FieldDecoder Api.Enum.RepositoryLockReason.RepositoryLockReason Api.Object.RepositoryInfo
lockReason =
    Object.fieldDecoder "lockReason" [] Api.Enum.RepositoryLockReason.decoder


mirrorUrl : FieldDecoder String Api.Object.RepositoryInfo
mirrorUrl =
    Object.fieldDecoder "mirrorUrl" [] Decode.string


name : FieldDecoder String Api.Object.RepositoryInfo
name =
    Object.fieldDecoder "name" [] Decode.string


nameWithOwner : FieldDecoder String Api.Object.RepositoryInfo
nameWithOwner =
    Object.fieldDecoder "nameWithOwner" [] Decode.string


owner : Object owner Api.Object.RepositoryOwner -> FieldDecoder owner Api.Object.RepositoryInfo
owner object =
    Object.single "owner" [] object


pushedAt : FieldDecoder String Api.Object.RepositoryInfo
pushedAt =
    Object.fieldDecoder "pushedAt" [] Decode.string


resourcePath : FieldDecoder String Api.Object.RepositoryInfo
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


shortDescriptionHTML : ({ limit : Maybe Int } -> { limit : Maybe Int }) -> FieldDecoder String Api.Object.RepositoryInfo
shortDescriptionHTML fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { limit = Nothing }

        optionalArgs =
            [ Argument.optional "limit" filledInOptionals.limit Value.int ]
                |> List.filterMap identity
    in
    Object.fieldDecoder "shortDescriptionHTML" optionalArgs Decode.string


updatedAt : FieldDecoder String Api.Object.RepositoryInfo
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.RepositoryInfo
url =
    Object.fieldDecoder "url" [] Decode.string
