module Github.Object.Repository exposing (..)

import Github.Enum.CollaboratorAffiliation
import Github.Enum.IssueState
import Github.Enum.OrderDirection
import Github.Enum.ProjectState
import Github.Enum.PullRequestState
import Github.Enum.RepositoryAffiliation
import Github.Enum.RepositoryLockReason
import Github.Enum.RepositoryPrivacy
import Github.Enum.SubscriptionState
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Repository
selection constructor =
    Object.object constructor


assignableUsers : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet assignableUsers Github.Object.UserConnection -> FieldDecoder assignableUsers Github.Object.Repository
assignableUsers fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "assignableUsers" optionalArgs object


codeOfConduct : SelectionSet codeOfConduct Github.Object.CodeOfConduct -> FieldDecoder codeOfConduct Github.Object.Repository
codeOfConduct object =
    Object.single "codeOfConduct" [] object


collaborators : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, affiliation : OptionalArgument Github.Enum.CollaboratorAffiliation.CollaboratorAffiliation } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, affiliation : OptionalArgument Github.Enum.CollaboratorAffiliation.CollaboratorAffiliation }) -> SelectionSet collaborators Github.Object.RepositoryCollaboratorConnection -> FieldDecoder collaborators Github.Object.Repository
collaborators fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, affiliation = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "affiliation" filledInOptionals.affiliation (Encode.enum toString) ]
                |> List.filterMap identity
    in
    Object.single "collaborators" optionalArgs object


commitComments : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet commitComments Github.Object.CommitCommentConnection -> FieldDecoder commitComments Github.Object.Repository
commitComments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "commitComments" optionalArgs object


createdAt : FieldDecoder String Github.Object.Repository
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder Int Github.Object.Repository
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


defaultBranchRef : SelectionSet defaultBranchRef Github.Object.Ref -> FieldDecoder defaultBranchRef Github.Object.Repository
defaultBranchRef object =
    Object.single "defaultBranchRef" [] object


deployKeys : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet deployKeys Github.Object.DeployKeyConnection -> FieldDecoder deployKeys Github.Object.Repository
deployKeys fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "deployKeys" optionalArgs object


deployments : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, environments : OptionalArgument (List String) } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, environments : OptionalArgument (List String) }) -> SelectionSet deployments Github.Object.DeploymentConnection -> FieldDecoder deployments Github.Object.Repository
deployments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, environments = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "environments" filledInOptionals.environments (Encode.string |> Encode.list) ]
                |> List.filterMap identity
    in
    Object.single "deployments" optionalArgs object


description : FieldDecoder String Github.Object.Repository
description =
    Object.fieldDecoder "description" [] Decode.string


descriptionHTML : FieldDecoder String Github.Object.Repository
descriptionHTML =
    Object.fieldDecoder "descriptionHTML" [] Decode.string


diskUsage : FieldDecoder Int Github.Object.Repository
diskUsage =
    Object.fieldDecoder "diskUsage" [] Decode.int


forkCount : FieldDecoder Int Github.Object.Repository
forkCount =
    Object.fieldDecoder "forkCount" [] Decode.int


forks : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Github.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List Github.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Github.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List Github.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : OptionalArgument Bool }) -> SelectionSet forks Github.Object.RepositoryConnection -> FieldDecoder forks Github.Object.Repository
forks fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, privacy = Absent, orderBy = Absent, affiliations = Absent, isLocked = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Encode.enum toString |> Encode.list), Argument.optional "isLocked" filledInOptionals.isLocked Encode.bool ]
                |> List.filterMap identity
    in
    Object.single "forks" optionalArgs object


hasIssuesEnabled : FieldDecoder Bool Github.Object.Repository
hasIssuesEnabled =
    Object.fieldDecoder "hasIssuesEnabled" [] Decode.bool


hasWikiEnabled : FieldDecoder Bool Github.Object.Repository
hasWikiEnabled =
    Object.fieldDecoder "hasWikiEnabled" [] Decode.bool


homepageUrl : FieldDecoder String Github.Object.Repository
homepageUrl =
    Object.fieldDecoder "homepageUrl" [] Decode.string


id : FieldDecoder String Github.Object.Repository
id =
    Object.fieldDecoder "id" [] Decode.string


isArchived : FieldDecoder Bool Github.Object.Repository
isArchived =
    Object.fieldDecoder "isArchived" [] Decode.bool


isFork : FieldDecoder Bool Github.Object.Repository
isFork =
    Object.fieldDecoder "isFork" [] Decode.bool


isLocked : FieldDecoder Bool Github.Object.Repository
isLocked =
    Object.fieldDecoder "isLocked" [] Decode.bool


isMirror : FieldDecoder Bool Github.Object.Repository
isMirror =
    Object.fieldDecoder "isMirror" [] Decode.bool


isPrivate : FieldDecoder Bool Github.Object.Repository
isPrivate =
    Object.fieldDecoder "isPrivate" [] Decode.bool


issue : { number : String } -> SelectionSet issue Github.Object.Issue -> FieldDecoder issue Github.Object.Repository
issue requiredArgs object =
    Object.single "issue" [ Argument.string "number" requiredArgs.number ] object


issueOrPullRequest : { number : String } -> FieldDecoder String Github.Object.Repository
issueOrPullRequest requiredArgs =
    Object.fieldDecoder "issueOrPullRequest" [ Argument.string "number" requiredArgs.number ] Decode.string


issues : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, labels : OptionalArgument (List String), orderBy : OptionalArgument Value, states : OptionalArgument (List Github.Enum.IssueState.IssueState) } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, labels : OptionalArgument (List String), orderBy : OptionalArgument Value, states : OptionalArgument (List Github.Enum.IssueState.IssueState) }) -> SelectionSet issues Github.Object.IssueConnection -> FieldDecoder issues Github.Object.Repository
issues fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, labels = Absent, orderBy = Absent, states = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "labels" filledInOptionals.labels (Encode.string |> Encode.list), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "states" filledInOptionals.states (Encode.enum toString |> Encode.list) ]
                |> List.filterMap identity
    in
    Object.single "issues" optionalArgs object


label : { name : String } -> SelectionSet label Github.Object.Label -> FieldDecoder label Github.Object.Repository
label requiredArgs object =
    Object.single "label" [ Argument.string "name" requiredArgs.name ] object


labels : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet labels Github.Object.LabelConnection -> FieldDecoder labels Github.Object.Repository
labels fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "labels" optionalArgs object


languages : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value }) -> SelectionSet languages Github.Object.LanguageConnection -> FieldDecoder languages Github.Object.Repository
languages fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "languages" optionalArgs object


license : FieldDecoder String Github.Object.Repository
license =
    Object.fieldDecoder "license" [] Decode.string


licenseInfo : SelectionSet licenseInfo Github.Object.License -> FieldDecoder licenseInfo Github.Object.Repository
licenseInfo object =
    Object.single "licenseInfo" [] object


lockReason : FieldDecoder Github.Enum.RepositoryLockReason.RepositoryLockReason Github.Object.Repository
lockReason =
    Object.fieldDecoder "lockReason" [] Github.Enum.RepositoryLockReason.decoder


mentionableUsers : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet mentionableUsers Github.Object.UserConnection -> FieldDecoder mentionableUsers Github.Object.Repository
mentionableUsers fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "mentionableUsers" optionalArgs object


milestone : { number : String } -> SelectionSet milestone Github.Object.Milestone -> FieldDecoder milestone Github.Object.Repository
milestone requiredArgs object =
    Object.single "milestone" [ Argument.string "number" requiredArgs.number ] object


milestones : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet milestones Github.Object.MilestoneConnection -> FieldDecoder milestones Github.Object.Repository
milestones fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "milestones" optionalArgs object


mirrorUrl : FieldDecoder String Github.Object.Repository
mirrorUrl =
    Object.fieldDecoder "mirrorUrl" [] Decode.string


name : FieldDecoder String Github.Object.Repository
name =
    Object.fieldDecoder "name" [] Decode.string


nameWithOwner : FieldDecoder String Github.Object.Repository
nameWithOwner =
    Object.fieldDecoder "nameWithOwner" [] Decode.string


object : ({ oid : OptionalArgument String, expression : OptionalArgument String } -> { oid : OptionalArgument String, expression : OptionalArgument String }) -> SelectionSet object Github.Object.GitObject -> FieldDecoder object Github.Object.Repository
object fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { oid = Absent, expression = Absent }

        optionalArgs =
            [ Argument.optional "oid" filledInOptionals.oid Encode.string, Argument.optional "expression" filledInOptionals.expression Encode.string ]
                |> List.filterMap identity
    in
    Object.single "object" optionalArgs object


owner : SelectionSet owner Github.Object.RepositoryOwner -> FieldDecoder owner Github.Object.Repository
owner object =
    Object.single "owner" [] object


parent : SelectionSet parent Github.Object.Repository -> FieldDecoder parent Github.Object.Repository
parent object =
    Object.single "parent" [] object


primaryLanguage : SelectionSet primaryLanguage Github.Object.Language -> FieldDecoder primaryLanguage Github.Object.Repository
primaryLanguage object =
    Object.single "primaryLanguage" [] object


project : { number : String } -> SelectionSet project Github.Object.Project -> FieldDecoder project Github.Object.Repository
project requiredArgs object =
    Object.single "project" [ Argument.string "number" requiredArgs.number ] object


projects : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value, search : OptionalArgument String, states : OptionalArgument (List Github.Enum.ProjectState.ProjectState) } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value, search : OptionalArgument String, states : OptionalArgument (List Github.Enum.ProjectState.ProjectState) }) -> SelectionSet projects Github.Object.ProjectConnection -> FieldDecoder projects Github.Object.Repository
projects fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, orderBy = Absent, search = Absent, states = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "search" filledInOptionals.search Encode.string, Argument.optional "states" filledInOptionals.states (Encode.enum toString |> Encode.list) ]
                |> List.filterMap identity
    in
    Object.single "projects" optionalArgs object


projectsResourcePath : FieldDecoder String Github.Object.Repository
projectsResourcePath =
    Object.fieldDecoder "projectsResourcePath" [] Decode.string


projectsUrl : FieldDecoder String Github.Object.Repository
projectsUrl =
    Object.fieldDecoder "projectsUrl" [] Decode.string


protectedBranches : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet protectedBranches Github.Object.ProtectedBranchConnection -> FieldDecoder protectedBranches Github.Object.Repository
protectedBranches fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "protectedBranches" optionalArgs object


pullRequest : { number : String } -> SelectionSet pullRequest Github.Object.PullRequest -> FieldDecoder pullRequest Github.Object.Repository
pullRequest requiredArgs object =
    Object.single "pullRequest" [ Argument.string "number" requiredArgs.number ] object


pullRequests : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, states : OptionalArgument (List Github.Enum.PullRequestState.PullRequestState), labels : OptionalArgument (List String), headRefName : OptionalArgument String, baseRefName : OptionalArgument String, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, states : OptionalArgument (List Github.Enum.PullRequestState.PullRequestState), labels : OptionalArgument (List String), headRefName : OptionalArgument String, baseRefName : OptionalArgument String, orderBy : OptionalArgument Value }) -> SelectionSet pullRequests Github.Object.PullRequestConnection -> FieldDecoder pullRequests Github.Object.Repository
pullRequests fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, states = Absent, labels = Absent, headRefName = Absent, baseRefName = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "states" filledInOptionals.states (Encode.enum toString |> Encode.list), Argument.optional "labels" filledInOptionals.labels (Encode.string |> Encode.list), Argument.optional "headRefName" filledInOptionals.headRefName Encode.string, Argument.optional "baseRefName" filledInOptionals.baseRefName Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "pullRequests" optionalArgs object


pushedAt : FieldDecoder String Github.Object.Repository
pushedAt =
    Object.fieldDecoder "pushedAt" [] Decode.string


ref : { qualifiedName : String } -> SelectionSet ref Github.Object.Ref -> FieldDecoder ref Github.Object.Repository
ref requiredArgs object =
    Object.single "ref" [ Argument.string "qualifiedName" requiredArgs.qualifiedName ] object


refs : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, direction : OptionalArgument Github.Enum.OrderDirection.OrderDirection, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, direction : OptionalArgument Github.Enum.OrderDirection.OrderDirection, orderBy : OptionalArgument Value }) -> { refPrefix : String } -> SelectionSet refs Github.Object.RefConnection -> FieldDecoder refs Github.Object.Repository
refs fillInOptionals requiredArgs object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, direction = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "direction" filledInOptionals.direction (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "refs" (optionalArgs ++ [ Argument.string "refPrefix" requiredArgs.refPrefix ]) object


release : { tagName : String } -> SelectionSet release Github.Object.Release -> FieldDecoder release Github.Object.Repository
release requiredArgs object =
    Object.single "release" [ Argument.string "tagName" requiredArgs.tagName ] object


releases : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value }) -> SelectionSet releases Github.Object.ReleaseConnection -> FieldDecoder releases Github.Object.Repository
releases fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "releases" optionalArgs object


repositoryTopics : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet repositoryTopics Github.Object.RepositoryTopicConnection -> FieldDecoder repositoryTopics Github.Object.Repository
repositoryTopics fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "repositoryTopics" optionalArgs object


resourcePath : FieldDecoder String Github.Object.Repository
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


shortDescriptionHTML : ({ limit : OptionalArgument Int } -> { limit : OptionalArgument Int }) -> FieldDecoder String Github.Object.Repository
shortDescriptionHTML fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { limit = Absent }

        optionalArgs =
            [ Argument.optional "limit" filledInOptionals.limit Encode.int ]
                |> List.filterMap identity
    in
    Object.fieldDecoder "shortDescriptionHTML" optionalArgs Decode.string


sshUrl : FieldDecoder String Github.Object.Repository
sshUrl =
    Object.fieldDecoder "sshUrl" [] Decode.string


stargazers : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value }) -> SelectionSet stargazers Github.Object.StargazerConnection -> FieldDecoder stargazers Github.Object.Repository
stargazers fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "stargazers" optionalArgs object


updatedAt : FieldDecoder String Github.Object.Repository
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Github.Object.Repository
url =
    Object.fieldDecoder "url" [] Decode.string


viewerCanAdminister : FieldDecoder Bool Github.Object.Repository
viewerCanAdminister =
    Object.fieldDecoder "viewerCanAdminister" [] Decode.bool


viewerCanCreateProjects : FieldDecoder Bool Github.Object.Repository
viewerCanCreateProjects =
    Object.fieldDecoder "viewerCanCreateProjects" [] Decode.bool


viewerCanSubscribe : FieldDecoder Bool Github.Object.Repository
viewerCanSubscribe =
    Object.fieldDecoder "viewerCanSubscribe" [] Decode.bool


viewerCanUpdateTopics : FieldDecoder Bool Github.Object.Repository
viewerCanUpdateTopics =
    Object.fieldDecoder "viewerCanUpdateTopics" [] Decode.bool


viewerHasStarred : FieldDecoder Bool Github.Object.Repository
viewerHasStarred =
    Object.fieldDecoder "viewerHasStarred" [] Decode.bool


viewerSubscription : FieldDecoder Github.Enum.SubscriptionState.SubscriptionState Github.Object.Repository
viewerSubscription =
    Object.fieldDecoder "viewerSubscription" [] Github.Enum.SubscriptionState.decoder


watchers : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet watchers Github.Object.UserConnection -> FieldDecoder watchers Github.Object.Repository
watchers fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "watchers" optionalArgs object
