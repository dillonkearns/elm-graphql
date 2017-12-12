module Api.Object.Repository exposing (..)

import Api.Enum.CollaboratorAffiliation
import Api.Enum.IssueState
import Api.Enum.OrderDirection
import Api.Enum.ProjectState
import Api.Enum.PullRequestState
import Api.Enum.RepositoryAffiliation
import Api.Enum.RepositoryLockReason
import Api.Enum.RepositoryPrivacy
import Api.Enum.SubscriptionState
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Repository
build constructor =
    Object.object constructor


assignableUsers : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object assignableUsers Api.Object.UserConnection -> FieldDecoder assignableUsers Api.Object.Repository
assignableUsers fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string ]
                |> List.filterMap identity
    in
    Object.single "assignableUsers" optionalArgs object


codeOfConduct : Object codeOfConduct Api.Object.CodeOfConduct -> FieldDecoder codeOfConduct Api.Object.Repository
codeOfConduct object =
    Object.single "codeOfConduct" [] object


collaborators : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, affiliation : Maybe Api.Enum.CollaboratorAffiliation.CollaboratorAffiliation } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, affiliation : Maybe Api.Enum.CollaboratorAffiliation.CollaboratorAffiliation }) -> Object collaborators Api.Object.RepositoryCollaboratorConnection -> FieldDecoder collaborators Api.Object.Repository
collaborators fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, affiliation = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string, Argument.optional "affiliation" filledInOptionals.affiliation (Value.enum toString) ]
                |> List.filterMap identity
    in
    Object.single "collaborators" optionalArgs object


commitComments : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object commitComments Api.Object.CommitCommentConnection -> FieldDecoder commitComments Api.Object.Repository
commitComments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string ]
                |> List.filterMap identity
    in
    Object.single "commitComments" optionalArgs object


createdAt : FieldDecoder String Api.Object.Repository
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder Int Api.Object.Repository
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


defaultBranchRef : Object defaultBranchRef Api.Object.Ref -> FieldDecoder defaultBranchRef Api.Object.Repository
defaultBranchRef object =
    Object.single "defaultBranchRef" [] object


deployKeys : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object deployKeys Api.Object.DeployKeyConnection -> FieldDecoder deployKeys Api.Object.Repository
deployKeys fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string ]
                |> List.filterMap identity
    in
    Object.single "deployKeys" optionalArgs object


deployments : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, environments : Maybe (List String) } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, environments : Maybe (List String) }) -> Object deployments Api.Object.DeploymentConnection -> FieldDecoder deployments Api.Object.Repository
deployments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, environments = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string, Argument.optional "environments" filledInOptionals.environments (Value.string |> Value.list) ]
                |> List.filterMap identity
    in
    Object.single "deployments" optionalArgs object


description : FieldDecoder String Api.Object.Repository
description =
    Object.fieldDecoder "description" [] Decode.string


descriptionHTML : FieldDecoder String Api.Object.Repository
descriptionHTML =
    Object.fieldDecoder "descriptionHTML" [] Decode.string


diskUsage : FieldDecoder Int Api.Object.Repository
diskUsage =
    Object.fieldDecoder "diskUsage" [] Decode.int


forkCount : FieldDecoder Int Api.Object.Repository
forkCount =
    Object.fieldDecoder "forkCount" [] Decode.int


forks : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, privacy : Maybe Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : Maybe Value, affiliations : Maybe (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : Maybe Bool } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, privacy : Maybe Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : Maybe Value, affiliations : Maybe (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : Maybe Bool }) -> Object forks Api.Object.RepositoryConnection -> FieldDecoder forks Api.Object.Repository
forks fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, privacy = Nothing, orderBy = Nothing, affiliations = Nothing, isLocked = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string, Argument.optional "privacy" filledInOptionals.privacy (Value.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Value.enum toString |> Value.list), Argument.optional "isLocked" filledInOptionals.isLocked Value.bool ]
                |> List.filterMap identity
    in
    Object.single "forks" optionalArgs object


hasIssuesEnabled : FieldDecoder Bool Api.Object.Repository
hasIssuesEnabled =
    Object.fieldDecoder "hasIssuesEnabled" [] Decode.bool


hasWikiEnabled : FieldDecoder Bool Api.Object.Repository
hasWikiEnabled =
    Object.fieldDecoder "hasWikiEnabled" [] Decode.bool


homepageUrl : FieldDecoder String Api.Object.Repository
homepageUrl =
    Object.fieldDecoder "homepageUrl" [] Decode.string


id : FieldDecoder String Api.Object.Repository
id =
    Object.fieldDecoder "id" [] Decode.string


isArchived : FieldDecoder Bool Api.Object.Repository
isArchived =
    Object.fieldDecoder "isArchived" [] Decode.bool


isFork : FieldDecoder Bool Api.Object.Repository
isFork =
    Object.fieldDecoder "isFork" [] Decode.bool


isLocked : FieldDecoder Bool Api.Object.Repository
isLocked =
    Object.fieldDecoder "isLocked" [] Decode.bool


isMirror : FieldDecoder Bool Api.Object.Repository
isMirror =
    Object.fieldDecoder "isMirror" [] Decode.bool


isPrivate : FieldDecoder Bool Api.Object.Repository
isPrivate =
    Object.fieldDecoder "isPrivate" [] Decode.bool


issue : { number : String } -> Object issue Api.Object.Issue -> FieldDecoder issue Api.Object.Repository
issue requiredArgs object =
    Object.single "issue" [ Argument.string "number" requiredArgs.number ] object


issueOrPullRequest : { number : String } -> FieldDecoder String Api.Object.Repository
issueOrPullRequest requiredArgs =
    Object.fieldDecoder "issueOrPullRequest" [ Argument.string "number" requiredArgs.number ] Decode.string


issues : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, labels : Maybe (List String), orderBy : Maybe Value, states : Maybe (List Api.Enum.IssueState.IssueState) } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, labels : Maybe (List String), orderBy : Maybe Value, states : Maybe (List Api.Enum.IssueState.IssueState) }) -> Object issues Api.Object.IssueConnection -> FieldDecoder issues Api.Object.Repository
issues fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, labels = Nothing, orderBy = Nothing, states = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string, Argument.optional "labels" filledInOptionals.labels (Value.string |> Value.list), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "states" filledInOptionals.states (Value.enum toString |> Value.list) ]
                |> List.filterMap identity
    in
    Object.single "issues" optionalArgs object


label : { name : String } -> Object label Api.Object.Label -> FieldDecoder label Api.Object.Repository
label requiredArgs object =
    Object.single "label" [ Argument.string "name" requiredArgs.name ] object


labels : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object labels Api.Object.LabelConnection -> FieldDecoder labels Api.Object.Repository
labels fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string ]
                |> List.filterMap identity
    in
    Object.single "labels" optionalArgs object


languages : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, orderBy : Maybe Value } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, orderBy : Maybe Value }) -> Object languages Api.Object.LanguageConnection -> FieldDecoder languages Api.Object.Repository
languages fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, orderBy = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "languages" optionalArgs object


license : FieldDecoder String Api.Object.Repository
license =
    Object.fieldDecoder "license" [] Decode.string


licenseInfo : Object licenseInfo Api.Object.License -> FieldDecoder licenseInfo Api.Object.Repository
licenseInfo object =
    Object.single "licenseInfo" [] object


lockReason : FieldDecoder Api.Enum.RepositoryLockReason.RepositoryLockReason Api.Object.Repository
lockReason =
    Object.fieldDecoder "lockReason" [] Api.Enum.RepositoryLockReason.decoder


mentionableUsers : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object mentionableUsers Api.Object.UserConnection -> FieldDecoder mentionableUsers Api.Object.Repository
mentionableUsers fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string ]
                |> List.filterMap identity
    in
    Object.single "mentionableUsers" optionalArgs object


milestone : { number : String } -> Object milestone Api.Object.Milestone -> FieldDecoder milestone Api.Object.Repository
milestone requiredArgs object =
    Object.single "milestone" [ Argument.string "number" requiredArgs.number ] object


milestones : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object milestones Api.Object.MilestoneConnection -> FieldDecoder milestones Api.Object.Repository
milestones fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string ]
                |> List.filterMap identity
    in
    Object.single "milestones" optionalArgs object


mirrorUrl : FieldDecoder String Api.Object.Repository
mirrorUrl =
    Object.fieldDecoder "mirrorUrl" [] Decode.string


name : FieldDecoder String Api.Object.Repository
name =
    Object.fieldDecoder "name" [] Decode.string


nameWithOwner : FieldDecoder String Api.Object.Repository
nameWithOwner =
    Object.fieldDecoder "nameWithOwner" [] Decode.string


object : ({ oid : Maybe String, expression : Maybe String } -> { oid : Maybe String, expression : Maybe String }) -> Object object Api.Object.GitObject -> FieldDecoder object Api.Object.Repository
object fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { oid = Nothing, expression = Nothing }

        optionalArgs =
            [ Argument.optional "oid" filledInOptionals.oid Value.string, Argument.optional "expression" filledInOptionals.expression Value.string ]
                |> List.filterMap identity
    in
    Object.single "object" optionalArgs object


owner : Object owner Api.Object.RepositoryOwner -> FieldDecoder owner Api.Object.Repository
owner object =
    Object.single "owner" [] object


parent : Object parent Api.Object.Repository -> FieldDecoder parent Api.Object.Repository
parent object =
    Object.single "parent" [] object


primaryLanguage : Object primaryLanguage Api.Object.Language -> FieldDecoder primaryLanguage Api.Object.Repository
primaryLanguage object =
    Object.single "primaryLanguage" [] object


project : { number : String } -> Object project Api.Object.Project -> FieldDecoder project Api.Object.Repository
project requiredArgs object =
    Object.single "project" [ Argument.string "number" requiredArgs.number ] object


projects : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, orderBy : Maybe Value, search : Maybe String, states : Maybe (List Api.Enum.ProjectState.ProjectState) } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, orderBy : Maybe Value, search : Maybe String, states : Maybe (List Api.Enum.ProjectState.ProjectState) }) -> Object projects Api.Object.ProjectConnection -> FieldDecoder projects Api.Object.Repository
projects fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, orderBy = Nothing, search = Nothing, states = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string, Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "search" filledInOptionals.search Value.string, Argument.optional "states" filledInOptionals.states (Value.enum toString |> Value.list) ]
                |> List.filterMap identity
    in
    Object.single "projects" optionalArgs object


projectsResourcePath : FieldDecoder String Api.Object.Repository
projectsResourcePath =
    Object.fieldDecoder "projectsResourcePath" [] Decode.string


projectsUrl : FieldDecoder String Api.Object.Repository
projectsUrl =
    Object.fieldDecoder "projectsUrl" [] Decode.string


protectedBranches : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object protectedBranches Api.Object.ProtectedBranchConnection -> FieldDecoder protectedBranches Api.Object.Repository
protectedBranches fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string ]
                |> List.filterMap identity
    in
    Object.single "protectedBranches" optionalArgs object


pullRequest : { number : String } -> Object pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.Repository
pullRequest requiredArgs object =
    Object.single "pullRequest" [ Argument.string "number" requiredArgs.number ] object


pullRequests : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, states : Maybe (List Api.Enum.PullRequestState.PullRequestState), labels : Maybe (List String), headRefName : Maybe String, baseRefName : Maybe String, orderBy : Maybe Value } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, states : Maybe (List Api.Enum.PullRequestState.PullRequestState), labels : Maybe (List String), headRefName : Maybe String, baseRefName : Maybe String, orderBy : Maybe Value }) -> Object pullRequests Api.Object.PullRequestConnection -> FieldDecoder pullRequests Api.Object.Repository
pullRequests fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, states = Nothing, labels = Nothing, headRefName = Nothing, baseRefName = Nothing, orderBy = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string, Argument.optional "states" filledInOptionals.states (Value.enum toString |> Value.list), Argument.optional "labels" filledInOptionals.labels (Value.string |> Value.list), Argument.optional "headRefName" filledInOptionals.headRefName Value.string, Argument.optional "baseRefName" filledInOptionals.baseRefName Value.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "pullRequests" optionalArgs object


pushedAt : FieldDecoder String Api.Object.Repository
pushedAt =
    Object.fieldDecoder "pushedAt" [] Decode.string


ref : { qualifiedName : String } -> Object ref Api.Object.Ref -> FieldDecoder ref Api.Object.Repository
ref requiredArgs object =
    Object.single "ref" [ Argument.string "qualifiedName" requiredArgs.qualifiedName ] object


refs : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, direction : Maybe Api.Enum.OrderDirection.OrderDirection, orderBy : Maybe Value } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, direction : Maybe Api.Enum.OrderDirection.OrderDirection, orderBy : Maybe Value }) -> { refPrefix : String } -> Object refs Api.Object.RefConnection -> FieldDecoder refs Api.Object.Repository
refs fillInOptionals requiredArgs object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, direction = Nothing, orderBy = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string, Argument.optional "direction" filledInOptionals.direction (Value.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "refs" (optionalArgs ++ [ Argument.string "refPrefix" requiredArgs.refPrefix ]) object


release : { tagName : String } -> Object release Api.Object.Release -> FieldDecoder release Api.Object.Repository
release requiredArgs object =
    Object.single "release" [ Argument.string "tagName" requiredArgs.tagName ] object


releases : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, orderBy : Maybe Value } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, orderBy : Maybe Value }) -> Object releases Api.Object.ReleaseConnection -> FieldDecoder releases Api.Object.Repository
releases fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, orderBy = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "releases" optionalArgs object


repositoryTopics : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object repositoryTopics Api.Object.RepositoryTopicConnection -> FieldDecoder repositoryTopics Api.Object.Repository
repositoryTopics fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string ]
                |> List.filterMap identity
    in
    Object.single "repositoryTopics" optionalArgs object


resourcePath : FieldDecoder String Api.Object.Repository
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


shortDescriptionHTML : ({ limit : Maybe Int } -> { limit : Maybe Int }) -> FieldDecoder String Api.Object.Repository
shortDescriptionHTML fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { limit = Nothing }

        optionalArgs =
            [ Argument.optional "limit" filledInOptionals.limit Value.int ]
                |> List.filterMap identity
    in
    Object.fieldDecoder "shortDescriptionHTML" optionalArgs Decode.string


stargazers : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, orderBy : Maybe Value } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, orderBy : Maybe Value }) -> Object stargazers Api.Object.StargazerConnection -> FieldDecoder stargazers Api.Object.Repository
stargazers fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, orderBy = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "stargazers" optionalArgs object


updatedAt : FieldDecoder String Api.Object.Repository
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.Repository
url =
    Object.fieldDecoder "url" [] Decode.string


viewerCanAdminister : FieldDecoder Bool Api.Object.Repository
viewerCanAdminister =
    Object.fieldDecoder "viewerCanAdminister" [] Decode.bool


viewerCanCreateProjects : FieldDecoder Bool Api.Object.Repository
viewerCanCreateProjects =
    Object.fieldDecoder "viewerCanCreateProjects" [] Decode.bool


viewerCanSubscribe : FieldDecoder Bool Api.Object.Repository
viewerCanSubscribe =
    Object.fieldDecoder "viewerCanSubscribe" [] Decode.bool


viewerCanUpdateTopics : FieldDecoder Bool Api.Object.Repository
viewerCanUpdateTopics =
    Object.fieldDecoder "viewerCanUpdateTopics" [] Decode.bool


viewerHasStarred : FieldDecoder Bool Api.Object.Repository
viewerHasStarred =
    Object.fieldDecoder "viewerHasStarred" [] Decode.bool


viewerSubscription : FieldDecoder Api.Enum.SubscriptionState.SubscriptionState Api.Object.Repository
viewerSubscription =
    Object.fieldDecoder "viewerSubscription" [] Api.Enum.SubscriptionState.decoder


watchers : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object watchers Api.Object.UserConnection -> FieldDecoder watchers Api.Object.Repository
watchers fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string ]
                |> List.filterMap identity
    in
    Object.single "watchers" optionalArgs object
