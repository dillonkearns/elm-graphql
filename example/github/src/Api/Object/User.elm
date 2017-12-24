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
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.User
selection constructor =
    Object.object constructor


avatarUrl : ({ size : Maybe Int } -> { size : Maybe Int }) -> FieldDecoder String Api.Object.User
avatarUrl fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { size = Nothing }

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


commitComments : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> SelectionSet commitComments Api.Object.CommitCommentConnection -> FieldDecoder commitComments Api.Object.User
commitComments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

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


contributedRepositories : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, privacy : Maybe Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : Maybe Value, affiliations : Maybe (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : Maybe Bool } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, privacy : Maybe Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : Maybe Value, affiliations : Maybe (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : Maybe Bool }) -> SelectionSet contributedRepositories Api.Object.RepositoryConnection -> FieldDecoder contributedRepositories Api.Object.User
contributedRepositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, privacy = Nothing, orderBy = Nothing, affiliations = Nothing, isLocked = Nothing }

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


followers : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> SelectionSet followers Api.Object.FollowerConnection -> FieldDecoder followers Api.Object.User
followers fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "followers" optionalArgs object


following : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> SelectionSet following Api.Object.FollowingConnection -> FieldDecoder following Api.Object.User
following fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "following" optionalArgs object


gist : { name : String } -> SelectionSet gist Api.Object.Gist -> FieldDecoder gist Api.Object.User
gist requiredArgs object =
    Object.single "gist" [ Argument.string "name" requiredArgs.name ] object


gistComments : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> SelectionSet gistComments Api.Object.GistCommentConnection -> FieldDecoder gistComments Api.Object.User
gistComments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "gistComments" optionalArgs object


gists : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, privacy : Maybe Api.Enum.GistPrivacy.GistPrivacy, orderBy : Maybe Value } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, privacy : Maybe Api.Enum.GistPrivacy.GistPrivacy, orderBy : Maybe Value }) -> SelectionSet gists Api.Object.GistConnection -> FieldDecoder gists Api.Object.User
gists fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, privacy = Nothing, orderBy = Nothing }

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


issueComments : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> SelectionSet issueComments Api.Object.IssueCommentConnection -> FieldDecoder issueComments Api.Object.User
issueComments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "issueComments" optionalArgs object


issues : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, labels : Maybe (List String), orderBy : Maybe Value, states : Maybe (List Api.Enum.IssueState.IssueState) } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, labels : Maybe (List String), orderBy : Maybe Value, states : Maybe (List Api.Enum.IssueState.IssueState) }) -> SelectionSet issues Api.Object.IssueConnection -> FieldDecoder issues Api.Object.User
issues fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, labels = Nothing, orderBy = Nothing, states = Nothing }

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


organizations : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> SelectionSet organizations Api.Object.OrganizationConnection -> FieldDecoder organizations Api.Object.User
organizations fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "organizations" optionalArgs object


pinnedRepositories : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, privacy : Maybe Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : Maybe Value, affiliations : Maybe (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : Maybe Bool } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, privacy : Maybe Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : Maybe Value, affiliations : Maybe (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : Maybe Bool }) -> SelectionSet pinnedRepositories Api.Object.RepositoryConnection -> FieldDecoder pinnedRepositories Api.Object.User
pinnedRepositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, privacy = Nothing, orderBy = Nothing, affiliations = Nothing, isLocked = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Encode.enum toString |> Encode.list), Argument.optional "isLocked" filledInOptionals.isLocked Encode.bool ]
                |> List.filterMap identity
    in
    Object.single "pinnedRepositories" optionalArgs object


publicKeys : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> SelectionSet publicKeys Api.Object.PublicKeyConnection -> FieldDecoder publicKeys Api.Object.User
publicKeys fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "publicKeys" optionalArgs object


pullRequests : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, states : Maybe (List Api.Enum.PullRequestState.PullRequestState), labels : Maybe (List String), headRefName : Maybe String, baseRefName : Maybe String, orderBy : Maybe Value } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, states : Maybe (List Api.Enum.PullRequestState.PullRequestState), labels : Maybe (List String), headRefName : Maybe String, baseRefName : Maybe String, orderBy : Maybe Value }) -> SelectionSet pullRequests Api.Object.PullRequestConnection -> FieldDecoder pullRequests Api.Object.User
pullRequests fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, states = Nothing, labels = Nothing, headRefName = Nothing, baseRefName = Nothing, orderBy = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "states" filledInOptionals.states (Encode.enum toString |> Encode.list), Argument.optional "labels" filledInOptionals.labels (Encode.string |> Encode.list), Argument.optional "headRefName" filledInOptionals.headRefName Encode.string, Argument.optional "baseRefName" filledInOptionals.baseRefName Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "pullRequests" optionalArgs object


repositories : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, privacy : Maybe Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : Maybe Value, affiliations : Maybe (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : Maybe Bool, isFork : Maybe Bool } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, privacy : Maybe Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : Maybe Value, affiliations : Maybe (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : Maybe Bool, isFork : Maybe Bool }) -> SelectionSet repositories Api.Object.RepositoryConnection -> FieldDecoder repositories Api.Object.User
repositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, privacy = Nothing, orderBy = Nothing, affiliations = Nothing, isLocked = Nothing, isFork = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Encode.enum toString |> Encode.list), Argument.optional "isLocked" filledInOptionals.isLocked Encode.bool, Argument.optional "isFork" filledInOptionals.isFork Encode.bool ]
                |> List.filterMap identity
    in
    Object.single "repositories" optionalArgs object


repositoriesContributedTo : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, privacy : Maybe Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : Maybe Value, isLocked : Maybe Bool, includeUserRepositories : Maybe Bool, contributionTypes : Maybe (List Api.Enum.RepositoryContributionType.RepositoryContributionType) } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, privacy : Maybe Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : Maybe Value, isLocked : Maybe Bool, includeUserRepositories : Maybe Bool, contributionTypes : Maybe (List Api.Enum.RepositoryContributionType.RepositoryContributionType) }) -> SelectionSet repositoriesContributedTo Api.Object.RepositoryConnection -> FieldDecoder repositoriesContributedTo Api.Object.User
repositoriesContributedTo fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, privacy = Nothing, orderBy = Nothing, isLocked = Nothing, includeUserRepositories = Nothing, contributionTypes = Nothing }

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


starredRepositories : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, ownedByViewer : Maybe Bool, orderBy : Maybe Value } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, ownedByViewer : Maybe Bool, orderBy : Maybe Value }) -> SelectionSet starredRepositories Api.Object.StarredRepositoryConnection -> FieldDecoder starredRepositories Api.Object.User
starredRepositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, ownedByViewer = Nothing, orderBy = Nothing }

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


watching : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, privacy : Maybe Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : Maybe Value, affiliations : Maybe (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : Maybe Bool } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, privacy : Maybe Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : Maybe Value, affiliations : Maybe (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : Maybe Bool }) -> SelectionSet watching Api.Object.RepositoryConnection -> FieldDecoder watching Api.Object.User
watching fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, privacy = Nothing, orderBy = Nothing, affiliations = Nothing, isLocked = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Encode.enum toString |> Encode.list), Argument.optional "isLocked" filledInOptionals.isLocked Encode.bool ]
                |> List.filterMap identity
    in
    Object.single "watching" optionalArgs object


websiteUrl : FieldDecoder String Api.Object.User
websiteUrl =
    Object.fieldDecoder "websiteUrl" [] Decode.string
