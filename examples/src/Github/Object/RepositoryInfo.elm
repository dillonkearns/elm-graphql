module Github.Object.RepositoryInfo exposing (..)

import Github.Enum.RepositoryLockReason
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.RepositoryInfo
selection constructor =
    Object.object constructor


createdAt : FieldDecoder String Github.Object.RepositoryInfo
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


description : FieldDecoder (Maybe String) Github.Object.RepositoryInfo
description =
    Object.fieldDecoder "description" [] (Decode.string |> Decode.maybe)


descriptionHTML : FieldDecoder String Github.Object.RepositoryInfo
descriptionHTML =
    Object.fieldDecoder "descriptionHTML" [] Decode.string


forkCount : FieldDecoder Int Github.Object.RepositoryInfo
forkCount =
    Object.fieldDecoder "forkCount" [] Decode.int


hasIssuesEnabled : FieldDecoder Bool Github.Object.RepositoryInfo
hasIssuesEnabled =
    Object.fieldDecoder "hasIssuesEnabled" [] Decode.bool


hasWikiEnabled : FieldDecoder Bool Github.Object.RepositoryInfo
hasWikiEnabled =
    Object.fieldDecoder "hasWikiEnabled" [] Decode.bool


homepageUrl : FieldDecoder (Maybe String) Github.Object.RepositoryInfo
homepageUrl =
    Object.fieldDecoder "homepageUrl" [] (Decode.string |> Decode.maybe)


isArchived : FieldDecoder Bool Github.Object.RepositoryInfo
isArchived =
    Object.fieldDecoder "isArchived" [] Decode.bool


isFork : FieldDecoder Bool Github.Object.RepositoryInfo
isFork =
    Object.fieldDecoder "isFork" [] Decode.bool


isLocked : FieldDecoder Bool Github.Object.RepositoryInfo
isLocked =
    Object.fieldDecoder "isLocked" [] Decode.bool


isMirror : FieldDecoder Bool Github.Object.RepositoryInfo
isMirror =
    Object.fieldDecoder "isMirror" [] Decode.bool


isPrivate : FieldDecoder Bool Github.Object.RepositoryInfo
isPrivate =
    Object.fieldDecoder "isPrivate" [] Decode.bool


license : FieldDecoder (Maybe String) Github.Object.RepositoryInfo
license =
    Object.fieldDecoder "license" [] (Decode.string |> Decode.maybe)


licenseInfo : SelectionSet licenseInfo Github.Object.License -> FieldDecoder (Maybe licenseInfo) Github.Object.RepositoryInfo
licenseInfo object =
    Object.selectionFieldDecoder "licenseInfo" [] object (identity >> Decode.maybe)


lockReason : FieldDecoder (Maybe Github.Enum.RepositoryLockReason.RepositoryLockReason) Github.Object.RepositoryInfo
lockReason =
    Object.fieldDecoder "lockReason" [] (Github.Enum.RepositoryLockReason.decoder |> Decode.maybe)


mirrorUrl : FieldDecoder (Maybe String) Github.Object.RepositoryInfo
mirrorUrl =
    Object.fieldDecoder "mirrorUrl" [] (Decode.string |> Decode.maybe)


name : FieldDecoder String Github.Object.RepositoryInfo
name =
    Object.fieldDecoder "name" [] Decode.string


nameWithOwner : FieldDecoder String Github.Object.RepositoryInfo
nameWithOwner =
    Object.fieldDecoder "nameWithOwner" [] Decode.string


owner : SelectionSet owner Github.Object.RepositoryOwner -> FieldDecoder owner Github.Object.RepositoryInfo
owner object =
    Object.selectionFieldDecoder "owner" [] object identity


pushedAt : FieldDecoder (Maybe String) Github.Object.RepositoryInfo
pushedAt =
    Object.fieldDecoder "pushedAt" [] (Decode.string |> Decode.maybe)


resourcePath : FieldDecoder String Github.Object.RepositoryInfo
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


shortDescriptionHTML : ({ limit : OptionalArgument Int } -> { limit : OptionalArgument Int }) -> FieldDecoder String Github.Object.RepositoryInfo
shortDescriptionHTML fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { limit = Absent }

        optionalArgs =
            [ Argument.optional "limit" filledInOptionals.limit Encode.int ]
                |> List.filterMap identity
    in
    Object.fieldDecoder "shortDescriptionHTML" optionalArgs Decode.string


updatedAt : FieldDecoder String Github.Object.RepositoryInfo
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Github.Object.RepositoryInfo
url =
    Object.fieldDecoder "url" [] Decode.string
