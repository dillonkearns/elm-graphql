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
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.Repository
selection constructor =
    Object.object constructor


assignableUsers : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet assignableUsers Api.Object.UserConnection -> FieldDecoder assignableUsers Api.Object.Repository
assignableUsers fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "assignableUsers" optionalArgs object


codeOfConduct : SelectionSet codeOfConduct Api.Object.CodeOfConduct -> FieldDecoder codeOfConduct Api.Object.Repository
codeOfConduct object =
    Object.single "codeOfConduct" [] object


collaborators : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, affiliation : OptionalArgument Api.Enum.CollaboratorAffiliation.CollaboratorAffiliation } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, affiliation : OptionalArgument Api.Enum.CollaboratorAffiliation.CollaboratorAffiliation }) -> SelectionSet collaborators Api.Object.RepositoryCollaboratorConnection -> FieldDecoder collaborators Api.Object.Repository
collaborators fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, affiliation = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "affiliation" filledInOptionals.affiliation (Encode.enum toString) ]
                |> List.filterMap identity
    in
    Object.single "collaborators" optionalArgs object


commitComments : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet commitComments Api.Object.CommitCommentConnection -> FieldDecoder commitComments Api.Object.Repository
commitComments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "commitComments" optionalArgs object


createdAt : FieldDecoder String Api.Object.Repository
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder Int Api.Object.Repository
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


defaultBranchRef : SelectionSet defaultBranchRef Api.Object.Ref -> FieldDecoder defaultBranchRef Api.Object.Repository
defaultBranchRef object =
    Object.single "defaultBranchRef" [] object


deployKeys : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet deployKeys Api.Object.DeployKeyConnection -> FieldDecoder deployKeys Api.Object.Repository
deployKeys fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "deployKeys" optionalArgs object


deployments : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, environments : OptionalArgument (List String) } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, environments : OptionalArgument (List String) }) -> SelectionSet deployments Api.Object.DeploymentConnection -> FieldDecoder deployments Api.Object.Repository
deployments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, environments = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "environments" filledInOptionals.environments (Encode.string |> Encode.list) ]
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


forks : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : OptionalArgument Bool }) -> SelectionSet forks Api.Object.RepositoryConnection -> FieldDecoder forks Api.Object.Repository
forks fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, privacy = Absent, orderBy = Absent, affiliations = Absent, isLocked = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Encode.enum toString |> Encode.list), Argument.optional "isLocked" filledInOptionals.isLocked Encode.bool ]
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


issue : { number : String } -> SelectionSet issue Api.Object.Issue -> FieldDecoder issue Api.Object.Repository
issue requiredArgs object =
    Object.single "issue" [ Argument.string "number" requiredArgs.number ] object


issueOrPullRequest : { number : String } -> FieldDecoder String Api.Object.Repository
issueOrPullRequest requiredArgs =
    Object.fieldDecoder "issueOrPullRequest" [ Argument.string "number" requiredArgs.number ] Decode.string


issues : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, labels : OptionalArgument (List String), orderBy : OptionalArgument Value, states : OptionalArgument (List Api.Enum.IssueState.IssueState) } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, labels : OptionalArgument (List String), orderBy : OptionalArgument Value, states : OptionalArgument (List Api.Enum.IssueState.IssueState) }) -> SelectionSet issues Api.Object.IssueConnection -> FieldDecoder issues Api.Object.Repository
issues fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, labels = Absent, orderBy = Absent, states = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "labels" filledInOptionals.labels (Encode.string |> Encode.list), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "states" filledInOptionals.states (Encode.enum toString |> Encode.list) ]
                |> List.filterMap identity
    in
    Object.single "issues" optionalArgs object


label : { name : String } -> SelectionSet label Api.Object.Label -> FieldDecoder label Api.Object.Repository
label requiredArgs object =
    Object.single "label" [ Argument.string "name" requiredArgs.name ] object


labels : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet labels Api.Object.LabelConnection -> FieldDecoder labels Api.Object.Repository
labels fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "labels" optionalArgs object


languages : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value }) -> SelectionSet languages Api.Object.LanguageConnection -> FieldDecoder languages Api.Object.Repository
languages fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "languages" optionalArgs object


license : FieldDecoder String Api.Object.Repository
license =
    Object.fieldDecoder "license" [] Decode.string


licenseInfo : SelectionSet licenseInfo Api.Object.License -> FieldDecoder licenseInfo Api.Object.Repository
licenseInfo object =
    Object.single "licenseInfo" [] object


lockReason : FieldDecoder Api.Enum.RepositoryLockReason.RepositoryLockReason Api.Object.Repository
lockReason =
    Object.fieldDecoder "lockReason" [] Api.Enum.RepositoryLockReason.decoder


mentionableUsers : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet mentionableUsers Api.Object.UserConnection -> FieldDecoder mentionableUsers Api.Object.Repository
mentionableUsers fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "mentionableUsers" optionalArgs object


milestone : { number : String } -> SelectionSet milestone Api.Object.Milestone -> FieldDecoder milestone Api.Object.Repository
milestone requiredArgs object =
    Object.single "milestone" [ Argument.string "number" requiredArgs.number ] object


milestones : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet milestones Api.Object.MilestoneConnection -> FieldDecoder milestones Api.Object.Repository
milestones fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
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


object : ({ oid : OptionalArgument String, expression : OptionalArgument String } -> { oid : OptionalArgument String, expression : OptionalArgument String }) -> SelectionSet object Api.Object.GitObject -> FieldDecoder object Api.Object.Repository
object fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { oid = Absent, expression = Absent }

        optionalArgs =
            [ Argument.optional "oid" filledInOptionals.oid Encode.string, Argument.optional "expression" filledInOptionals.expression Encode.string ]
                |> List.filterMap identity
    in
    Object.single "object" optionalArgs object


owner : SelectionSet owner Api.Object.RepositoryOwner -> FieldDecoder owner Api.Object.Repository
owner object =
    Object.single "owner" [] object


parent : SelectionSet parent Api.Object.Repository -> FieldDecoder parent Api.Object.Repository
parent object =
    Object.single "parent" [] object


primaryLanguage : SelectionSet primaryLanguage Api.Object.Language -> FieldDecoder primaryLanguage Api.Object.Repository
primaryLanguage object =
    Object.single "primaryLanguage" [] object


project : { number : String } -> SelectionSet project Api.Object.Project -> FieldDecoder project Api.Object.Repository
project requiredArgs object =
    Object.single "project" [ Argument.string "number" requiredArgs.number ] object


projects : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value, search : OptionalArgument String, states : OptionalArgument (List Api.Enum.ProjectState.ProjectState) } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value, search : OptionalArgument String, states : OptionalArgument (List Api.Enum.ProjectState.ProjectState) }) -> SelectionSet projects Api.Object.ProjectConnection -> FieldDecoder projects Api.Object.Repository
projects fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, orderBy = Absent, search = Absent, states = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "search" filledInOptionals.search Encode.string, Argument.optional "states" filledInOptionals.states (Encode.enum toString |> Encode.list) ]
                |> List.filterMap identity
    in
    Object.single "projects" optionalArgs object


projectsResourcePath : FieldDecoder String Api.Object.Repository
projectsResourcePath =
    Object.fieldDecoder "projectsResourcePath" [] Decode.string


projectsUrl : FieldDecoder String Api.Object.Repository
projectsUrl =
    Object.fieldDecoder "projectsUrl" [] Decode.string


protectedBranches : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet protectedBranches Api.Object.ProtectedBranchConnection -> FieldDecoder protectedBranches Api.Object.Repository
protectedBranches fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "protectedBranches" optionalArgs object


pullRequest : { number : String } -> SelectionSet pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.Repository
pullRequest requiredArgs object =
    Object.single "pullRequest" [ Argument.string "number" requiredArgs.number ] object


pullRequests : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, states : OptionalArgument (List Api.Enum.PullRequestState.PullRequestState), labels : OptionalArgument (List String), headRefName : OptionalArgument String, baseRefName : OptionalArgument String, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, states : OptionalArgument (List Api.Enum.PullRequestState.PullRequestState), labels : OptionalArgument (List String), headRefName : OptionalArgument String, baseRefName : OptionalArgument String, orderBy : OptionalArgument Value }) -> SelectionSet pullRequests Api.Object.PullRequestConnection -> FieldDecoder pullRequests Api.Object.Repository
pullRequests fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, states = Absent, labels = Absent, headRefName = Absent, baseRefName = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "states" filledInOptionals.states (Encode.enum toString |> Encode.list), Argument.optional "labels" filledInOptionals.labels (Encode.string |> Encode.list), Argument.optional "headRefName" filledInOptionals.headRefName Encode.string, Argument.optional "baseRefName" filledInOptionals.baseRefName Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "pullRequests" optionalArgs object


pushedAt : FieldDecoder String Api.Object.Repository
pushedAt =
    Object.fieldDecoder "pushedAt" [] Decode.string


ref : { qualifiedName : String } -> SelectionSet ref Api.Object.Ref -> FieldDecoder ref Api.Object.Repository
ref requiredArgs object =
    Object.single "ref" [ Argument.string "qualifiedName" requiredArgs.qualifiedName ] object


refs : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, direction : OptionalArgument Api.Enum.OrderDirection.OrderDirection, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, direction : OptionalArgument Api.Enum.OrderDirection.OrderDirection, orderBy : OptionalArgument Value }) -> { refPrefix : String } -> SelectionSet refs Api.Object.RefConnection -> FieldDecoder refs Api.Object.Repository
refs fillInOptionals requiredArgs object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, direction = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "direction" filledInOptionals.direction (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "refs" (optionalArgs ++ [ Argument.string "refPrefix" requiredArgs.refPrefix ]) object


release : { tagName : String } -> SelectionSet release Api.Object.Release -> FieldDecoder release Api.Object.Repository
release requiredArgs object =
    Object.single "release" [ Argument.string "tagName" requiredArgs.tagName ] object


releases : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value }) -> SelectionSet releases Api.Object.ReleaseConnection -> FieldDecoder releases Api.Object.Repository
releases fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "releases" optionalArgs object


repositoryTopics : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet repositoryTopics Api.Object.RepositoryTopicConnection -> FieldDecoder repositoryTopics Api.Object.Repository
repositoryTopics fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "repositoryTopics" optionalArgs object


resourcePath : FieldDecoder String Api.Object.Repository
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


shortDescriptionHTML : ({ limit : OptionalArgument Int } -> { limit : OptionalArgument Int }) -> FieldDecoder String Api.Object.Repository
shortDescriptionHTML fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { limit = Absent }

        optionalArgs =
            [ Argument.optional "limit" filledInOptionals.limit Encode.int ]
                |> List.filterMap identity
    in
    Object.fieldDecoder "shortDescriptionHTML" optionalArgs Decode.string


sshUrl : FieldDecoder String Api.Object.Repository
sshUrl =
    Object.fieldDecoder "sshUrl" [] Decode.string


stargazers : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value }) -> SelectionSet stargazers Api.Object.StargazerConnection -> FieldDecoder stargazers Api.Object.Repository
stargazers fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
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


watchers : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet watchers Api.Object.UserConnection -> FieldDecoder watchers Api.Object.Repository
watchers fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "watchers" optionalArgs object
