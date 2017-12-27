module Api.Object.User exposing (..)

import Api.Enum.GistPrivacy
import Api.Enum.IssueState
import Api.Enum.PullRequestState
import Api.Enum.RepositoryAffiliation
import Api.Enum.RepositoryContributionType
import Api.Enum.RepositoryPrivacy
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.User
selection constructor =
    Object.object constructor


avatarUrl : ({ size : OptionalArgument Int } -> { size : OptionalArgument Int }) -> FieldDecoder String Api.Object.User
avatarUrl fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { size = Absent }

        optionalArgs =
            [ Argument.optional "size" filledInOptionals.size Encode.int ]
                |> List.filterMap identity
    in
    Object.fieldDecoder "avatarUrl" optionalArgs Decode.string


bio : FieldDecoder String Api.Object.User
bio =
    Object.fieldDecoder "bio" [] Decode.string


bioHTML : FieldDecoder String Api.Object.User
bioHTML =
    Object.fieldDecoder "bioHTML" [] Decode.string


commitComments : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet commitComments Api.Object.CommitCommentConnection -> FieldDecoder commitComments Api.Object.User
commitComments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "commitComments" optionalArgs object


company : FieldDecoder String Api.Object.User
company =
    Object.fieldDecoder "company" [] Decode.string


companyHTML : FieldDecoder String Api.Object.User
companyHTML =
    Object.fieldDecoder "companyHTML" [] Decode.string


contributedRepositories : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : OptionalArgument Bool }) -> SelectionSet contributedRepositories Api.Object.RepositoryConnection -> FieldDecoder contributedRepositories Api.Object.User
contributedRepositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, privacy = Absent, orderBy = Absent, affiliations = Absent, isLocked = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Encode.enum toString |> Encode.list), Argument.optional "isLocked" filledInOptionals.isLocked Encode.bool ]
                |> List.filterMap identity
    in
    Object.single "contributedRepositories" optionalArgs object


createdAt : FieldDecoder String Api.Object.User
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder Int Api.Object.User
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


email : FieldDecoder String Api.Object.User
email =
    Object.fieldDecoder "email" [] Decode.string


followers : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet followers Api.Object.FollowerConnection -> FieldDecoder followers Api.Object.User
followers fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "followers" optionalArgs object


following : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet following Api.Object.FollowingConnection -> FieldDecoder following Api.Object.User
following fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "following" optionalArgs object


gist : { name : String } -> SelectionSet gist Api.Object.Gist -> FieldDecoder gist Api.Object.User
gist requiredArgs object =
    Object.single "gist" [ Argument.string "name" requiredArgs.name ] object


gistComments : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet gistComments Api.Object.GistCommentConnection -> FieldDecoder gistComments Api.Object.User
gistComments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "gistComments" optionalArgs object


gists : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Api.Enum.GistPrivacy.GistPrivacy, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Api.Enum.GistPrivacy.GistPrivacy, orderBy : OptionalArgument Value }) -> SelectionSet gists Api.Object.GistConnection -> FieldDecoder gists Api.Object.User
gists fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, privacy = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "gists" optionalArgs object


id : FieldDecoder String Api.Object.User
id =
    Object.fieldDecoder "id" [] Decode.string


isBountyHunter : FieldDecoder Bool Api.Object.User
isBountyHunter =
    Object.fieldDecoder "isBountyHunter" [] Decode.bool


isCampusExpert : FieldDecoder Bool Api.Object.User
isCampusExpert =
    Object.fieldDecoder "isCampusExpert" [] Decode.bool


isDeveloperProgramMember : FieldDecoder Bool Api.Object.User
isDeveloperProgramMember =
    Object.fieldDecoder "isDeveloperProgramMember" [] Decode.bool


isEmployee : FieldDecoder Bool Api.Object.User
isEmployee =
    Object.fieldDecoder "isEmployee" [] Decode.bool


isHireable : FieldDecoder Bool Api.Object.User
isHireable =
    Object.fieldDecoder "isHireable" [] Decode.bool


isSiteAdmin : FieldDecoder Bool Api.Object.User
isSiteAdmin =
    Object.fieldDecoder "isSiteAdmin" [] Decode.bool


isViewer : FieldDecoder Bool Api.Object.User
isViewer =
    Object.fieldDecoder "isViewer" [] Decode.bool


issueComments : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet issueComments Api.Object.IssueCommentConnection -> FieldDecoder issueComments Api.Object.User
issueComments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "issueComments" optionalArgs object


issues : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, labels : OptionalArgument (List String), orderBy : OptionalArgument Value, states : OptionalArgument (List Api.Enum.IssueState.IssueState) } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, labels : OptionalArgument (List String), orderBy : OptionalArgument Value, states : OptionalArgument (List Api.Enum.IssueState.IssueState) }) -> SelectionSet issues Api.Object.IssueConnection -> FieldDecoder issues Api.Object.User
issues fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, labels = Absent, orderBy = Absent, states = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "labels" filledInOptionals.labels (Encode.string |> Encode.list), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "states" filledInOptionals.states (Encode.enum toString |> Encode.list) ]
                |> List.filterMap identity
    in
    Object.single "issues" optionalArgs object


location : FieldDecoder String Api.Object.User
location =
    Object.fieldDecoder "location" [] Decode.string


login : FieldDecoder String Api.Object.User
login =
    Object.fieldDecoder "login" [] Decode.string


name : FieldDecoder String Api.Object.User
name =
    Object.fieldDecoder "name" [] Decode.string


organization : { login : String } -> SelectionSet organization Api.Object.Organization -> FieldDecoder organization Api.Object.User
organization requiredArgs object =
    Object.single "organization" [ Argument.string "login" requiredArgs.login ] object


organizations : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet organizations Api.Object.OrganizationConnection -> FieldDecoder organizations Api.Object.User
organizations fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "organizations" optionalArgs object


pinnedRepositories : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : OptionalArgument Bool }) -> SelectionSet pinnedRepositories Api.Object.RepositoryConnection -> FieldDecoder pinnedRepositories Api.Object.User
pinnedRepositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, privacy = Absent, orderBy = Absent, affiliations = Absent, isLocked = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Encode.enum toString |> Encode.list), Argument.optional "isLocked" filledInOptionals.isLocked Encode.bool ]
                |> List.filterMap identity
    in
    Object.single "pinnedRepositories" optionalArgs object


publicKeys : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet publicKeys Api.Object.PublicKeyConnection -> FieldDecoder publicKeys Api.Object.User
publicKeys fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "publicKeys" optionalArgs object


pullRequests : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, states : OptionalArgument (List Api.Enum.PullRequestState.PullRequestState), labels : OptionalArgument (List String), headRefName : OptionalArgument String, baseRefName : OptionalArgument String, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, states : OptionalArgument (List Api.Enum.PullRequestState.PullRequestState), labels : OptionalArgument (List String), headRefName : OptionalArgument String, baseRefName : OptionalArgument String, orderBy : OptionalArgument Value }) -> SelectionSet pullRequests Api.Object.PullRequestConnection -> FieldDecoder pullRequests Api.Object.User
pullRequests fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, states = Absent, labels = Absent, headRefName = Absent, baseRefName = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "states" filledInOptionals.states (Encode.enum toString |> Encode.list), Argument.optional "labels" filledInOptionals.labels (Encode.string |> Encode.list), Argument.optional "headRefName" filledInOptionals.headRefName Encode.string, Argument.optional "baseRefName" filledInOptionals.baseRefName Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "pullRequests" optionalArgs object


repositories : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : OptionalArgument Bool, isFork : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : OptionalArgument Bool, isFork : OptionalArgument Bool }) -> SelectionSet repositories Api.Object.RepositoryConnection -> FieldDecoder repositories Api.Object.User
repositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, privacy = Absent, orderBy = Absent, affiliations = Absent, isLocked = Absent, isFork = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Encode.enum toString |> Encode.list), Argument.optional "isLocked" filledInOptionals.isLocked Encode.bool, Argument.optional "isFork" filledInOptionals.isFork Encode.bool ]
                |> List.filterMap identity
    in
    Object.single "repositories" optionalArgs object


repositoriesContributedTo : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, isLocked : OptionalArgument Bool, includeUserRepositories : OptionalArgument Bool, contributionTypes : OptionalArgument (List Api.Enum.RepositoryContributionType.RepositoryContributionType) } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, isLocked : OptionalArgument Bool, includeUserRepositories : OptionalArgument Bool, contributionTypes : OptionalArgument (List Api.Enum.RepositoryContributionType.RepositoryContributionType) }) -> SelectionSet repositoriesContributedTo Api.Object.RepositoryConnection -> FieldDecoder repositoriesContributedTo Api.Object.User
repositoriesContributedTo fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, privacy = Absent, orderBy = Absent, isLocked = Absent, includeUserRepositories = Absent, contributionTypes = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "isLocked" filledInOptionals.isLocked Encode.bool, Argument.optional "includeUserRepositories" filledInOptionals.includeUserRepositories Encode.bool, Argument.optional "contributionTypes" filledInOptionals.contributionTypes (Encode.enum toString |> Encode.list) ]
                |> List.filterMap identity
    in
    Object.single "repositoriesContributedTo" optionalArgs object


repository : { name : String } -> SelectionSet repository Api.Object.Repository -> FieldDecoder repository Api.Object.User
repository requiredArgs object =
    Object.single "repository" [ Argument.string "name" requiredArgs.name ] object


resourcePath : FieldDecoder String Api.Object.User
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


starredRepositories : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, ownedByViewer : OptionalArgument Bool, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, ownedByViewer : OptionalArgument Bool, orderBy : OptionalArgument Value }) -> SelectionSet starredRepositories Api.Object.StarredRepositoryConnection -> FieldDecoder starredRepositories Api.Object.User
starredRepositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, ownedByViewer = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "ownedByViewer" filledInOptionals.ownedByViewer Encode.bool, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "starredRepositories" optionalArgs object


updatedAt : FieldDecoder String Api.Object.User
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.User
url =
    Object.fieldDecoder "url" [] Decode.string


viewerCanFollow : FieldDecoder Bool Api.Object.User
viewerCanFollow =
    Object.fieldDecoder "viewerCanFollow" [] Decode.bool


viewerIsFollowing : FieldDecoder Bool Api.Object.User
viewerIsFollowing =
    Object.fieldDecoder "viewerIsFollowing" [] Decode.bool


watching : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : OptionalArgument Bool }) -> SelectionSet watching Api.Object.RepositoryConnection -> FieldDecoder watching Api.Object.User
watching fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, privacy = Absent, orderBy = Absent, affiliations = Absent, isLocked = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Encode.enum toString |> Encode.list), Argument.optional "isLocked" filledInOptionals.isLocked Encode.bool ]
                |> List.filterMap identity
    in
    Object.single "watching" optionalArgs object


websiteUrl : FieldDecoder String Api.Object.User
websiteUrl =
    Object.fieldDecoder "websiteUrl" [] Decode.string
