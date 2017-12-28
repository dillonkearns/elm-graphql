module Github.Object.RepositoryInvitationRepository exposing (..)

import Github.Enum.RepositoryLockReason
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.RepositoryInvitationRepository
selection constructor =
    Object.object constructor


createdAt : FieldDecoder String Github.Object.RepositoryInvitationRepository
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


description : FieldDecoder String Github.Object.RepositoryInvitationRepository
description =
    Object.fieldDecoder "description" [] Decode.string


descriptionHTML : FieldDecoder String Github.Object.RepositoryInvitationRepository
descriptionHTML =
    Object.fieldDecoder "descriptionHTML" [] Decode.string


forkCount : FieldDecoder Int Github.Object.RepositoryInvitationRepository
forkCount =
    Object.fieldDecoder "forkCount" [] Decode.int


hasIssuesEnabled : FieldDecoder Bool Github.Object.RepositoryInvitationRepository
hasIssuesEnabled =
    Object.fieldDecoder "hasIssuesEnabled" [] Decode.bool


hasWikiEnabled : FieldDecoder Bool Github.Object.RepositoryInvitationRepository
hasWikiEnabled =
    Object.fieldDecoder "hasWikiEnabled" [] Decode.bool


homepageUrl : FieldDecoder String Github.Object.RepositoryInvitationRepository
homepageUrl =
    Object.fieldDecoder "homepageUrl" [] Decode.string


isArchived : FieldDecoder Bool Github.Object.RepositoryInvitationRepository
isArchived =
    Object.fieldDecoder "isArchived" [] Decode.bool


isFork : FieldDecoder Bool Github.Object.RepositoryInvitationRepository
isFork =
    Object.fieldDecoder "isFork" [] Decode.bool


isLocked : FieldDecoder Bool Github.Object.RepositoryInvitationRepository
isLocked =
    Object.fieldDecoder "isLocked" [] Decode.bool


isMirror : FieldDecoder Bool Github.Object.RepositoryInvitationRepository
isMirror =
    Object.fieldDecoder "isMirror" [] Decode.bool


isPrivate : FieldDecoder Bool Github.Object.RepositoryInvitationRepository
isPrivate =
    Object.fieldDecoder "isPrivate" [] Decode.bool


license : FieldDecoder String Github.Object.RepositoryInvitationRepository
license =
    Object.fieldDecoder "license" [] Decode.string


licenseInfo : SelectionSet licenseInfo Github.Object.License -> FieldDecoder licenseInfo Github.Object.RepositoryInvitationRepository
licenseInfo object =
    Object.selectionFieldDecoder "licenseInfo" [] object identity


lockReason : FieldDecoder Github.Enum.RepositoryLockReason.RepositoryLockReason Github.Object.RepositoryInvitationRepository
lockReason =
    Object.fieldDecoder "lockReason" [] Github.Enum.RepositoryLockReason.decoder


mirrorUrl : FieldDecoder String Github.Object.RepositoryInvitationRepository
mirrorUrl =
    Object.fieldDecoder "mirrorUrl" [] Decode.string


name : FieldDecoder String Github.Object.RepositoryInvitationRepository
name =
    Object.fieldDecoder "name" [] Decode.string


nameWithOwner : FieldDecoder String Github.Object.RepositoryInvitationRepository
nameWithOwner =
    Object.fieldDecoder "nameWithOwner" [] Decode.string


owner : SelectionSet owner Github.Object.RepositoryOwner -> FieldDecoder owner Github.Object.RepositoryInvitationRepository
owner object =
    Object.selectionFieldDecoder "owner" [] object identity


pushedAt : FieldDecoder String Github.Object.RepositoryInvitationRepository
pushedAt =
    Object.fieldDecoder "pushedAt" [] Decode.string


resourcePath : FieldDecoder String Github.Object.RepositoryInvitationRepository
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


shortDescriptionHTML : ({ limit : OptionalArgument Int } -> { limit : OptionalArgument Int }) -> FieldDecoder String Github.Object.RepositoryInvitationRepository
shortDescriptionHTML fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { limit = Absent }

        optionalArgs =
            [ Argument.optional "limit" filledInOptionals.limit Encode.int ]
                |> List.filterMap identity
    in
    Object.fieldDecoder "shortDescriptionHTML" optionalArgs Decode.string


updatedAt : FieldDecoder String Github.Object.RepositoryInvitationRepository
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Github.Object.RepositoryInvitationRepository
url =
    Object.fieldDecoder "url" [] Decode.string
