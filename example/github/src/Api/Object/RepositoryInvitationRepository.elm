module Api.Object.RepositoryInvitationRepository exposing (..)

import Api.Enum.RepositoryLockReason
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RepositoryInvitationRepository
build constructor =
    Object.object constructor


createdAt : FieldDecoder String Api.Object.RepositoryInvitationRepository
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


description : FieldDecoder String Api.Object.RepositoryInvitationRepository
description =
    Object.fieldDecoder "description" [] Decode.string


descriptionHTML : FieldDecoder String Api.Object.RepositoryInvitationRepository
descriptionHTML =
    Object.fieldDecoder "descriptionHTML" [] Decode.string


forkCount : FieldDecoder Int Api.Object.RepositoryInvitationRepository
forkCount =
    Object.fieldDecoder "forkCount" [] Decode.int


hasIssuesEnabled : FieldDecoder Bool Api.Object.RepositoryInvitationRepository
hasIssuesEnabled =
    Object.fieldDecoder "hasIssuesEnabled" [] Decode.bool


hasWikiEnabled : FieldDecoder Bool Api.Object.RepositoryInvitationRepository
hasWikiEnabled =
    Object.fieldDecoder "hasWikiEnabled" [] Decode.bool


homepageUrl : FieldDecoder String Api.Object.RepositoryInvitationRepository
homepageUrl =
    Object.fieldDecoder "homepageUrl" [] Decode.string


isArchived : FieldDecoder Bool Api.Object.RepositoryInvitationRepository
isArchived =
    Object.fieldDecoder "isArchived" [] Decode.bool


isFork : FieldDecoder Bool Api.Object.RepositoryInvitationRepository
isFork =
    Object.fieldDecoder "isFork" [] Decode.bool


isLocked : FieldDecoder Bool Api.Object.RepositoryInvitationRepository
isLocked =
    Object.fieldDecoder "isLocked" [] Decode.bool


isMirror : FieldDecoder Bool Api.Object.RepositoryInvitationRepository
isMirror =
    Object.fieldDecoder "isMirror" [] Decode.bool


isPrivate : FieldDecoder Bool Api.Object.RepositoryInvitationRepository
isPrivate =
    Object.fieldDecoder "isPrivate" [] Decode.bool


license : FieldDecoder String Api.Object.RepositoryInvitationRepository
license =
    Object.fieldDecoder "license" [] Decode.string


licenseInfo : Object licenseInfo Api.Object.License -> FieldDecoder licenseInfo Api.Object.RepositoryInvitationRepository
licenseInfo object =
    Object.single "licenseInfo" [] object


lockReason : FieldDecoder Api.Enum.RepositoryLockReason.RepositoryLockReason Api.Object.RepositoryInvitationRepository
lockReason =
    Object.fieldDecoder "lockReason" [] Api.Enum.RepositoryLockReason.decoder


mirrorUrl : FieldDecoder String Api.Object.RepositoryInvitationRepository
mirrorUrl =
    Object.fieldDecoder "mirrorUrl" [] Decode.string


name : FieldDecoder String Api.Object.RepositoryInvitationRepository
name =
    Object.fieldDecoder "name" [] Decode.string


nameWithOwner : FieldDecoder String Api.Object.RepositoryInvitationRepository
nameWithOwner =
    Object.fieldDecoder "nameWithOwner" [] Decode.string


owner : Object owner Api.Object.RepositoryOwner -> FieldDecoder owner Api.Object.RepositoryInvitationRepository
owner object =
    Object.single "owner" [] object


pushedAt : FieldDecoder String Api.Object.RepositoryInvitationRepository
pushedAt =
    Object.fieldDecoder "pushedAt" [] Decode.string


resourcePath : FieldDecoder String Api.Object.RepositoryInvitationRepository
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


shortDescriptionHTML : ({ limit : Maybe Int } -> { limit : Maybe Int }) -> FieldDecoder String Api.Object.RepositoryInvitationRepository
shortDescriptionHTML fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { limit = Nothing }

        optionalArgs =
            [ Argument.optional "limit" filledInOptionals.limit Value.int ]
                |> List.filterMap identity
    in
    Object.fieldDecoder "shortDescriptionHTML" optionalArgs Decode.string


updatedAt : FieldDecoder String Api.Object.RepositoryInvitationRepository
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.RepositoryInvitationRepository
url =
    Object.fieldDecoder "url" [] Decode.string
