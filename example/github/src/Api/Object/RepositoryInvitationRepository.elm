module Api.Object.RepositoryInvitationRepository exposing (..)

import Api.Enum.RepositoryLockReason
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RepositoryInvitationRepository
build constructor =
    Object.object constructor


createdAt : FieldDecoder String Api.Object.RepositoryInvitationRepository
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


description : FieldDecoder String Api.Object.RepositoryInvitationRepository
description =
    Field.fieldDecoder "description" [] Decode.string


descriptionHTML : FieldDecoder String Api.Object.RepositoryInvitationRepository
descriptionHTML =
    Field.fieldDecoder "descriptionHTML" [] Decode.string


forkCount : FieldDecoder String Api.Object.RepositoryInvitationRepository
forkCount =
    Field.fieldDecoder "forkCount" [] Decode.string


hasIssuesEnabled : FieldDecoder String Api.Object.RepositoryInvitationRepository
hasIssuesEnabled =
    Field.fieldDecoder "hasIssuesEnabled" [] Decode.string


hasWikiEnabled : FieldDecoder String Api.Object.RepositoryInvitationRepository
hasWikiEnabled =
    Field.fieldDecoder "hasWikiEnabled" [] Decode.string


homepageUrl : FieldDecoder String Api.Object.RepositoryInvitationRepository
homepageUrl =
    Field.fieldDecoder "homepageUrl" [] Decode.string


isArchived : FieldDecoder String Api.Object.RepositoryInvitationRepository
isArchived =
    Field.fieldDecoder "isArchived" [] Decode.string


isFork : FieldDecoder String Api.Object.RepositoryInvitationRepository
isFork =
    Field.fieldDecoder "isFork" [] Decode.string


isLocked : FieldDecoder String Api.Object.RepositoryInvitationRepository
isLocked =
    Field.fieldDecoder "isLocked" [] Decode.string


isMirror : FieldDecoder String Api.Object.RepositoryInvitationRepository
isMirror =
    Field.fieldDecoder "isMirror" [] Decode.string


isPrivate : FieldDecoder String Api.Object.RepositoryInvitationRepository
isPrivate =
    Field.fieldDecoder "isPrivate" [] Decode.string


license : FieldDecoder String Api.Object.RepositoryInvitationRepository
license =
    Field.fieldDecoder "license" [] Decode.string


licenseInfo : Object licenseInfo Api.Object.License -> FieldDecoder licenseInfo Api.Object.RepositoryInvitationRepository
licenseInfo object =
    Object.single "licenseInfo" [] object


lockReason : FieldDecoder Api.Enum.RepositoryLockReason.RepositoryLockReason Api.Object.RepositoryInvitationRepository
lockReason =
    Field.fieldDecoder "lockReason" [] Api.Enum.RepositoryLockReason.decoder


mirrorUrl : FieldDecoder String Api.Object.RepositoryInvitationRepository
mirrorUrl =
    Field.fieldDecoder "mirrorUrl" [] Decode.string


name : FieldDecoder String Api.Object.RepositoryInvitationRepository
name =
    Field.fieldDecoder "name" [] Decode.string


nameWithOwner : FieldDecoder String Api.Object.RepositoryInvitationRepository
nameWithOwner =
    Field.fieldDecoder "nameWithOwner" [] Decode.string


owner : Object owner Api.Object.RepositoryOwner -> FieldDecoder owner Api.Object.RepositoryInvitationRepository
owner object =
    Object.single "owner" [] object


pushedAt : FieldDecoder String Api.Object.RepositoryInvitationRepository
pushedAt =
    Field.fieldDecoder "pushedAt" [] Decode.string


resourcePath : FieldDecoder String Api.Object.RepositoryInvitationRepository
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


shortDescriptionHTML : FieldDecoder String Api.Object.RepositoryInvitationRepository
shortDescriptionHTML =
    Field.fieldDecoder "shortDescriptionHTML" [] Decode.string


updatedAt : FieldDecoder String Api.Object.RepositoryInvitationRepository
updatedAt =
    Field.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.RepositoryInvitationRepository
url =
    Field.fieldDecoder "url" [] Decode.string
