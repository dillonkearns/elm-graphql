module Github.Object.RepositoryInvitationRepository exposing (..)

import Github.Enum.RepositoryLockReason
import Github.Interface
import Github.Object
import Github.Union
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


{-| Select fields to build up a SelectionSet for this object.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.RepositoryInvitationRepository
selection constructor =
    Object.selection constructor


{-| Identifies the date and time when the object was created.
-}
createdAt : FieldDecoder String Github.Object.RepositoryInvitationRepository
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


{-| The description of the repository.
-}
description : FieldDecoder (Maybe String) Github.Object.RepositoryInvitationRepository
description =
    Object.fieldDecoder "description" [] (Decode.string |> Decode.maybe)


{-| The description of the repository rendered to HTML.
-}
descriptionHTML : FieldDecoder String Github.Object.RepositoryInvitationRepository
descriptionHTML =
    Object.fieldDecoder "descriptionHTML" [] Decode.string


{-| Returns how many forks there are of this repository in the whole network.
-}
forkCount : FieldDecoder Int Github.Object.RepositoryInvitationRepository
forkCount =
    Object.fieldDecoder "forkCount" [] Decode.int


{-| Indicates if the repository has issues feature enabled.
-}
hasIssuesEnabled : FieldDecoder Bool Github.Object.RepositoryInvitationRepository
hasIssuesEnabled =
    Object.fieldDecoder "hasIssuesEnabled" [] Decode.bool


{-| Indicates if the repository has wiki feature enabled.
-}
hasWikiEnabled : FieldDecoder Bool Github.Object.RepositoryInvitationRepository
hasWikiEnabled =
    Object.fieldDecoder "hasWikiEnabled" [] Decode.bool


{-| The repository's URL.
-}
homepageUrl : FieldDecoder (Maybe String) Github.Object.RepositoryInvitationRepository
homepageUrl =
    Object.fieldDecoder "homepageUrl" [] (Decode.string |> Decode.maybe)


{-| Indicates if the repository is unmaintained.
-}
isArchived : FieldDecoder Bool Github.Object.RepositoryInvitationRepository
isArchived =
    Object.fieldDecoder "isArchived" [] Decode.bool


{-| Identifies if the repository is a fork.
-}
isFork : FieldDecoder Bool Github.Object.RepositoryInvitationRepository
isFork =
    Object.fieldDecoder "isFork" [] Decode.bool


{-| Indicates if the repository has been locked or not.
-}
isLocked : FieldDecoder Bool Github.Object.RepositoryInvitationRepository
isLocked =
    Object.fieldDecoder "isLocked" [] Decode.bool


{-| Identifies if the repository is a mirror.
-}
isMirror : FieldDecoder Bool Github.Object.RepositoryInvitationRepository
isMirror =
    Object.fieldDecoder "isMirror" [] Decode.bool


{-| Identifies if the repository is private.
-}
isPrivate : FieldDecoder Bool Github.Object.RepositoryInvitationRepository
isPrivate =
    Object.fieldDecoder "isPrivate" [] Decode.bool


{-| The license associated with the repository
-}
licenseInfo : SelectionSet selection Github.Object.License -> FieldDecoder (Maybe selection) Github.Object.RepositoryInvitationRepository
licenseInfo object =
    Object.selectionFieldDecoder "licenseInfo" [] object (identity >> Decode.maybe)


{-| The reason the repository has been locked.
-}
lockReason : FieldDecoder (Maybe Github.Enum.RepositoryLockReason.RepositoryLockReason) Github.Object.RepositoryInvitationRepository
lockReason =
    Object.fieldDecoder "lockReason" [] (Github.Enum.RepositoryLockReason.decoder |> Decode.maybe)


{-| The repository's original mirror URL.
-}
mirrorUrl : FieldDecoder (Maybe String) Github.Object.RepositoryInvitationRepository
mirrorUrl =
    Object.fieldDecoder "mirrorUrl" [] (Decode.string |> Decode.maybe)


{-| The name of the repository.
-}
name : FieldDecoder String Github.Object.RepositoryInvitationRepository
name =
    Object.fieldDecoder "name" [] Decode.string


{-| The repository's name with owner.
-}
nameWithOwner : FieldDecoder String Github.Object.RepositoryInvitationRepository
nameWithOwner =
    Object.fieldDecoder "nameWithOwner" [] Decode.string


{-| The owner of the repository associated with this invitation repository.
-}
owner : SelectionSet selection Github.Interface.RepositoryOwner -> FieldDecoder selection Github.Object.RepositoryInvitationRepository
owner object =
    Object.selectionFieldDecoder "owner" [] object identity


{-| Identifies when the repository was last pushed to.
-}
pushedAt : FieldDecoder (Maybe String) Github.Object.RepositoryInvitationRepository
pushedAt =
    Object.fieldDecoder "pushedAt" [] (Decode.string |> Decode.maybe)


{-| The HTTP path for this repository
-}
resourcePath : FieldDecoder String Github.Object.RepositoryInvitationRepository
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


{-| A description of the repository, rendered to HTML without any links in it.

  - limit - How many characters to return.

-}
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


{-| The HTTP URL for this repository
-}
url : FieldDecoder String Github.Object.RepositoryInvitationRepository
url =
    Object.fieldDecoder "url" [] Decode.string
