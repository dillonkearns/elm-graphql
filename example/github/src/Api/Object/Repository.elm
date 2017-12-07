module Api.Object.Repository exposing (..)

import Api.Enum.RepositoryLockReason
import Api.Enum.SubscriptionState
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Repository
build constructor =
    Object.object constructor


assignableUsers : Object assignableUsers Api.Object.UserConnection -> FieldDecoder assignableUsers Api.Object.Repository
assignableUsers object =
    Object.single "assignableUsers" [] object


codeOfConduct : Object codeOfConduct Api.Object.CodeOfConduct -> FieldDecoder codeOfConduct Api.Object.Repository
codeOfConduct object =
    Object.single "codeOfConduct" [] object


collaborators : Object collaborators Api.Object.RepositoryCollaboratorConnection -> FieldDecoder collaborators Api.Object.Repository
collaborators object =
    Object.single "collaborators" [] object


commitComments : Object commitComments Api.Object.CommitCommentConnection -> FieldDecoder commitComments Api.Object.Repository
commitComments object =
    Object.single "commitComments" [] object


createdAt : FieldDecoder String Api.Object.Repository
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder Int Api.Object.Repository
databaseId =
    Field.fieldDecoder "databaseId" [] Decode.int


defaultBranchRef : Object defaultBranchRef Api.Object.Ref -> FieldDecoder defaultBranchRef Api.Object.Repository
defaultBranchRef object =
    Object.single "defaultBranchRef" [] object


deployments : Object deployments Api.Object.DeploymentConnection -> FieldDecoder deployments Api.Object.Repository
deployments object =
    Object.single "deployments" [] object


description : FieldDecoder String Api.Object.Repository
description =
    Field.fieldDecoder "description" [] Decode.string


descriptionHTML : FieldDecoder String Api.Object.Repository
descriptionHTML =
    Field.fieldDecoder "descriptionHTML" [] Decode.string


diskUsage : FieldDecoder Int Api.Object.Repository
diskUsage =
    Field.fieldDecoder "diskUsage" [] Decode.int


forkCount : FieldDecoder Int Api.Object.Repository
forkCount =
    Field.fieldDecoder "forkCount" [] Decode.int


forks : Object forks Api.Object.RepositoryConnection -> FieldDecoder forks Api.Object.Repository
forks object =
    Object.single "forks" [] object


hasIssuesEnabled : FieldDecoder Bool Api.Object.Repository
hasIssuesEnabled =
    Field.fieldDecoder "hasIssuesEnabled" [] Decode.bool


hasWikiEnabled : FieldDecoder Bool Api.Object.Repository
hasWikiEnabled =
    Field.fieldDecoder "hasWikiEnabled" [] Decode.bool


homepageUrl : FieldDecoder String Api.Object.Repository
homepageUrl =
    Field.fieldDecoder "homepageUrl" [] Decode.string


id : FieldDecoder String Api.Object.Repository
id =
    Field.fieldDecoder "id" [] Decode.string


isArchived : FieldDecoder Bool Api.Object.Repository
isArchived =
    Field.fieldDecoder "isArchived" [] Decode.bool


isFork : FieldDecoder Bool Api.Object.Repository
isFork =
    Field.fieldDecoder "isFork" [] Decode.bool


isLocked : FieldDecoder Bool Api.Object.Repository
isLocked =
    Field.fieldDecoder "isLocked" [] Decode.bool


isMirror : FieldDecoder Bool Api.Object.Repository
isMirror =
    Field.fieldDecoder "isMirror" [] Decode.bool


isPrivate : FieldDecoder Bool Api.Object.Repository
isPrivate =
    Field.fieldDecoder "isPrivate" [] Decode.bool


issue : { number : String } -> Object issue Api.Object.Issue -> FieldDecoder issue Api.Object.Repository
issue requiredArgs object =
    Object.single "issue" [ Argument.string "number" requiredArgs.number ] object


issueOrPullRequest : { number : String } -> FieldDecoder String Api.Object.Repository
issueOrPullRequest requiredArgs =
    Field.fieldDecoder "issueOrPullRequest" [ Argument.string "number" requiredArgs.number ] Decode.string


issues : Object issues Api.Object.IssueConnection -> FieldDecoder issues Api.Object.Repository
issues object =
    Object.single "issues" [] object


label : { name : String } -> Object label Api.Object.Label -> FieldDecoder label Api.Object.Repository
label requiredArgs object =
    Object.single "label" [ Argument.string "name" requiredArgs.name ] object


labels : Object labels Api.Object.LabelConnection -> FieldDecoder labels Api.Object.Repository
labels object =
    Object.single "labels" [] object


languages : Object languages Api.Object.LanguageConnection -> FieldDecoder languages Api.Object.Repository
languages object =
    Object.single "languages" [] object


license : FieldDecoder String Api.Object.Repository
license =
    Field.fieldDecoder "license" [] Decode.string


licenseInfo : Object licenseInfo Api.Object.License -> FieldDecoder licenseInfo Api.Object.Repository
licenseInfo object =
    Object.single "licenseInfo" [] object


lockReason : FieldDecoder Api.Enum.RepositoryLockReason.RepositoryLockReason Api.Object.Repository
lockReason =
    Field.fieldDecoder "lockReason" [] Api.Enum.RepositoryLockReason.decoder


mentionableUsers : Object mentionableUsers Api.Object.UserConnection -> FieldDecoder mentionableUsers Api.Object.Repository
mentionableUsers object =
    Object.single "mentionableUsers" [] object


milestone : { number : String } -> Object milestone Api.Object.Milestone -> FieldDecoder milestone Api.Object.Repository
milestone requiredArgs object =
    Object.single "milestone" [ Argument.string "number" requiredArgs.number ] object


milestones : Object milestones Api.Object.MilestoneConnection -> FieldDecoder milestones Api.Object.Repository
milestones object =
    Object.single "milestones" [] object


mirrorUrl : FieldDecoder String Api.Object.Repository
mirrorUrl =
    Field.fieldDecoder "mirrorUrl" [] Decode.string


name : FieldDecoder String Api.Object.Repository
name =
    Field.fieldDecoder "name" [] Decode.string


nameWithOwner : FieldDecoder String Api.Object.Repository
nameWithOwner =
    Field.fieldDecoder "nameWithOwner" [] Decode.string


object : Object object Api.Object.GitObject -> FieldDecoder object Api.Object.Repository
object object =
    Object.single "object" [] object


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


projects : Object projects Api.Object.ProjectConnection -> FieldDecoder projects Api.Object.Repository
projects object =
    Object.single "projects" [] object


projectsResourcePath : FieldDecoder String Api.Object.Repository
projectsResourcePath =
    Field.fieldDecoder "projectsResourcePath" [] Decode.string


projectsUrl : FieldDecoder String Api.Object.Repository
projectsUrl =
    Field.fieldDecoder "projectsUrl" [] Decode.string


protectedBranches : Object protectedBranches Api.Object.ProtectedBranchConnection -> FieldDecoder protectedBranches Api.Object.Repository
protectedBranches object =
    Object.single "protectedBranches" [] object


pullRequest : { number : String } -> Object pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.Repository
pullRequest requiredArgs object =
    Object.single "pullRequest" [ Argument.string "number" requiredArgs.number ] object


pullRequests : Object pullRequests Api.Object.PullRequestConnection -> FieldDecoder pullRequests Api.Object.Repository
pullRequests object =
    Object.single "pullRequests" [] object


pushedAt : FieldDecoder String Api.Object.Repository
pushedAt =
    Field.fieldDecoder "pushedAt" [] Decode.string


ref : { qualifiedName : String } -> Object ref Api.Object.Ref -> FieldDecoder ref Api.Object.Repository
ref requiredArgs object =
    Object.single "ref" [ Argument.string "qualifiedName" requiredArgs.qualifiedName ] object


refs : { refPrefix : String } -> Object refs Api.Object.RefConnection -> FieldDecoder refs Api.Object.Repository
refs requiredArgs object =
    Object.single "refs" [ Argument.string "refPrefix" requiredArgs.refPrefix ] object


release : { tagName : String } -> Object release Api.Object.Release -> FieldDecoder release Api.Object.Repository
release requiredArgs object =
    Object.single "release" [ Argument.string "tagName" requiredArgs.tagName ] object


releases : Object releases Api.Object.ReleaseConnection -> FieldDecoder releases Api.Object.Repository
releases object =
    -- Object.single "releases" [] object
    Object.single "releases" [ Argument.int "last" 10 ] object


repositoryTopics : Object repositoryTopics Api.Object.RepositoryTopicConnection -> FieldDecoder repositoryTopics Api.Object.Repository
repositoryTopics object =
    Object.single "repositoryTopics" [] object


resourcePath : FieldDecoder String Api.Object.Repository
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


shortDescriptionHTML : FieldDecoder String Api.Object.Repository
shortDescriptionHTML =
    Field.fieldDecoder "shortDescriptionHTML" [] Decode.string


stargazers : Object stargazers Api.Object.StargazerConnection -> FieldDecoder stargazers Api.Object.Repository
stargazers object =
    Object.single "stargazers" [] object


updatedAt : FieldDecoder String Api.Object.Repository
updatedAt =
    Field.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.Repository
url =
    Field.fieldDecoder "url" [] Decode.string


viewerCanAdminister : FieldDecoder Bool Api.Object.Repository
viewerCanAdminister =
    Field.fieldDecoder "viewerCanAdminister" [] Decode.bool


viewerCanCreateProjects : FieldDecoder Bool Api.Object.Repository
viewerCanCreateProjects =
    Field.fieldDecoder "viewerCanCreateProjects" [] Decode.bool


viewerCanSubscribe : FieldDecoder Bool Api.Object.Repository
viewerCanSubscribe =
    Field.fieldDecoder "viewerCanSubscribe" [] Decode.bool


viewerCanUpdateTopics : FieldDecoder Bool Api.Object.Repository
viewerCanUpdateTopics =
    Field.fieldDecoder "viewerCanUpdateTopics" [] Decode.bool


viewerHasStarred : FieldDecoder Bool Api.Object.Repository
viewerHasStarred =
    Field.fieldDecoder "viewerHasStarred" [] Decode.bool


viewerSubscription : FieldDecoder Api.Enum.SubscriptionState.SubscriptionState Api.Object.Repository
viewerSubscription =
    Field.fieldDecoder "viewerSubscription" [] Api.Enum.SubscriptionState.decoder


watchers : Object watchers Api.Object.UserConnection -> FieldDecoder watchers Api.Object.Repository
watchers object =
    Object.single "watchers" [] object
