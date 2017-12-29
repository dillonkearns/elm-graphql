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
    Object.selectionFieldDecoder "assignableUsers" optionalArgs object identity


codeOfConduct : SelectionSet codeOfConduct Github.Object.CodeOfConduct -> FieldDecoder (Maybe codeOfConduct) Github.Object.Repository
codeOfConduct object =
    Object.selectionFieldDecoder "codeOfConduct" [] object (identity >> Decode.maybe)


collaborators : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, affiliation : OptionalArgument Github.Enum.CollaboratorAffiliation.CollaboratorAffiliation } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, affiliation : OptionalArgument Github.Enum.CollaboratorAffiliation.CollaboratorAffiliation }) -> SelectionSet collaborators Github.Object.RepositoryCollaboratorConnection -> FieldDecoder (Maybe collaborators) Github.Object.Repository
collaborators fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, affiliation = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "affiliation" filledInOptionals.affiliation (Encode.enum toString) ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "collaborators" optionalArgs object (identity >> Decode.maybe)


commitComments : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet commitComments Github.Object.CommitCommentConnection -> FieldDecoder commitComments Github.Object.Repository
commitComments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "commitComments" optionalArgs object identity


createdAt : FieldDecoder String Github.Object.Repository
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder (Maybe Int) Github.Object.Repository
databaseId =
    Object.fieldDecoder "databaseId" [] (Decode.int |> Decode.maybe)


defaultBranchRef : SelectionSet defaultBranchRef Github.Object.Ref -> FieldDecoder (Maybe defaultBranchRef) Github.Object.Repository
defaultBranchRef object =
    Object.selectionFieldDecoder "defaultBranchRef" [] object (identity >> Decode.maybe)


deployKeys : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet deployKeys Github.Object.DeployKeyConnection -> FieldDecoder deployKeys Github.Object.Repository
deployKeys fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "deployKeys" optionalArgs object identity


deployments : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, environments : OptionalArgument (List String) } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, environments : OptionalArgument (List String) }) -> SelectionSet deployments Github.Object.DeploymentConnection -> FieldDecoder deployments Github.Object.Repository
deployments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, environments = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "environments" filledInOptionals.environments (Encode.string |> Encode.list) ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "deployments" optionalArgs object identity


description : FieldDecoder (Maybe String) Github.Object.Repository
description =
    Object.fieldDecoder "description" [] (Decode.string |> Decode.maybe)


descriptionHTML : FieldDecoder String Github.Object.Repository
descriptionHTML =
    Object.fieldDecoder "descriptionHTML" [] Decode.string


diskUsage : FieldDecoder (Maybe Int) Github.Object.Repository
diskUsage =
    Object.fieldDecoder "diskUsage" [] (Decode.int |> Decode.maybe)


forkCount : FieldDecoder Int Github.Object.Repository
forkCount =
    Object.fieldDecoder "forkCount" [] Decode.int


forks : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Github.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List (Maybe Github.Enum.RepositoryAffiliation.RepositoryAffiliation)), isLocked : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Github.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List (Maybe Github.Enum.RepositoryAffiliation.RepositoryAffiliation)), isLocked : OptionalArgument Bool }) -> SelectionSet forks Github.Object.RepositoryConnection -> FieldDecoder forks Github.Object.Repository
forks fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, privacy = Absent, orderBy = Absent, affiliations = Absent, isLocked = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Encode.enum toString |> Encode.maybe |> Encode.list), Argument.optional "isLocked" filledInOptionals.isLocked Encode.bool ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "forks" optionalArgs object identity


hasIssuesEnabled : FieldDecoder Bool Github.Object.Repository
hasIssuesEnabled =
    Object.fieldDecoder "hasIssuesEnabled" [] Decode.bool


hasWikiEnabled : FieldDecoder Bool Github.Object.Repository
hasWikiEnabled =
    Object.fieldDecoder "hasWikiEnabled" [] Decode.bool


homepageUrl : FieldDecoder (Maybe String) Github.Object.Repository
homepageUrl =
    Object.fieldDecoder "homepageUrl" [] (Decode.string |> Decode.maybe)


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


issue : { number : String } -> SelectionSet issue Github.Object.Issue -> FieldDecoder (Maybe issue) Github.Object.Repository
issue requiredArgs object =
    Object.selectionFieldDecoder "issue" [ Argument.required "number" (requiredArgs.number |> Encode.string) ] object (identity >> Decode.maybe)


issueOrPullRequest : { number : String } -> FieldDecoder (Maybe String) Github.Object.Repository
issueOrPullRequest requiredArgs =
    Object.fieldDecoder "issueOrPullRequest" [ Argument.required "number" (requiredArgs.number |> Encode.string) ] (Decode.string |> Decode.maybe)


issues : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, labels : OptionalArgument (List String), orderBy : OptionalArgument Value, states : OptionalArgument (List Github.Enum.IssueState.IssueState) } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, labels : OptionalArgument (List String), orderBy : OptionalArgument Value, states : OptionalArgument (List Github.Enum.IssueState.IssueState) }) -> SelectionSet issues Github.Object.IssueConnection -> FieldDecoder issues Github.Object.Repository
issues fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, labels = Absent, orderBy = Absent, states = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "labels" filledInOptionals.labels (Encode.string |> Encode.list), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "states" filledInOptionals.states (Encode.enum toString |> Encode.list) ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "issues" optionalArgs object identity


label : { name : String } -> SelectionSet label Github.Object.Label -> FieldDecoder (Maybe label) Github.Object.Repository
label requiredArgs object =
    Object.selectionFieldDecoder "label" [ Argument.required "name" (requiredArgs.name |> Encode.string) ] object (identity >> Decode.maybe)


labels : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet labels Github.Object.LabelConnection -> FieldDecoder (Maybe labels) Github.Object.Repository
labels fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "labels" optionalArgs object (identity >> Decode.maybe)


languages : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value }) -> SelectionSet languages Github.Object.LanguageConnection -> FieldDecoder (Maybe languages) Github.Object.Repository
languages fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "languages" optionalArgs object (identity >> Decode.maybe)


license : FieldDecoder (Maybe String) Github.Object.Repository
license =
    Object.fieldDecoder "license" [] (Decode.string |> Decode.maybe)


licenseInfo : SelectionSet licenseInfo Github.Object.License -> FieldDecoder (Maybe licenseInfo) Github.Object.Repository
licenseInfo object =
    Object.selectionFieldDecoder "licenseInfo" [] object (identity >> Decode.maybe)


lockReason : FieldDecoder (Maybe Github.Enum.RepositoryLockReason.RepositoryLockReason) Github.Object.Repository
lockReason =
    Object.fieldDecoder "lockReason" [] (Github.Enum.RepositoryLockReason.decoder |> Decode.maybe)


mentionableUsers : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet mentionableUsers Github.Object.UserConnection -> FieldDecoder mentionableUsers Github.Object.Repository
mentionableUsers fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "mentionableUsers" optionalArgs object identity


milestone : { number : String } -> SelectionSet milestone Github.Object.Milestone -> FieldDecoder (Maybe milestone) Github.Object.Repository
milestone requiredArgs object =
    Object.selectionFieldDecoder "milestone" [ Argument.required "number" (requiredArgs.number |> Encode.string) ] object (identity >> Decode.maybe)


milestones : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet milestones Github.Object.MilestoneConnection -> FieldDecoder (Maybe milestones) Github.Object.Repository
milestones fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "milestones" optionalArgs object (identity >> Decode.maybe)


mirrorUrl : FieldDecoder (Maybe String) Github.Object.Repository
mirrorUrl =
    Object.fieldDecoder "mirrorUrl" [] (Decode.string |> Decode.maybe)


name : FieldDecoder String Github.Object.Repository
name =
    Object.fieldDecoder "name" [] Decode.string


nameWithOwner : FieldDecoder String Github.Object.Repository
nameWithOwner =
    Object.fieldDecoder "nameWithOwner" [] Decode.string


object : ({ oid : OptionalArgument String, expression : OptionalArgument String } -> { oid : OptionalArgument String, expression : OptionalArgument String }) -> SelectionSet object Github.Object.GitObject -> FieldDecoder (Maybe object) Github.Object.Repository
object fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { oid = Absent, expression = Absent }

        optionalArgs =
            [ Argument.optional "oid" filledInOptionals.oid Encode.string, Argument.optional "expression" filledInOptionals.expression Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "object" optionalArgs object (identity >> Decode.maybe)


owner : SelectionSet owner Github.Object.RepositoryOwner -> FieldDecoder owner Github.Object.Repository
owner object =
    Object.selectionFieldDecoder "owner" [] object identity


parent : SelectionSet parent Github.Object.Repository -> FieldDecoder (Maybe parent) Github.Object.Repository
parent object =
    Object.selectionFieldDecoder "parent" [] object (identity >> Decode.maybe)


primaryLanguage : SelectionSet primaryLanguage Github.Object.Language -> FieldDecoder (Maybe primaryLanguage) Github.Object.Repository
primaryLanguage object =
    Object.selectionFieldDecoder "primaryLanguage" [] object (identity >> Decode.maybe)


project : { number : String } -> SelectionSet project Github.Object.Project -> FieldDecoder (Maybe project) Github.Object.Repository
project requiredArgs object =
    Object.selectionFieldDecoder "project" [ Argument.required "number" (requiredArgs.number |> Encode.string) ] object (identity >> Decode.maybe)


projects : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value, search : OptionalArgument String, states : OptionalArgument (List Github.Enum.ProjectState.ProjectState) } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value, search : OptionalArgument String, states : OptionalArgument (List Github.Enum.ProjectState.ProjectState) }) -> SelectionSet projects Github.Object.ProjectConnection -> FieldDecoder projects Github.Object.Repository
projects fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, orderBy = Absent, search = Absent, states = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "search" filledInOptionals.search Encode.string, Argument.optional "states" filledInOptionals.states (Encode.enum toString |> Encode.list) ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "projects" optionalArgs object identity


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
    Object.selectionFieldDecoder "protectedBranches" optionalArgs object identity


pullRequest : { number : String } -> SelectionSet pullRequest Github.Object.PullRequest -> FieldDecoder (Maybe pullRequest) Github.Object.Repository
pullRequest requiredArgs object =
    Object.selectionFieldDecoder "pullRequest" [ Argument.required "number" (requiredArgs.number |> Encode.string) ] object (identity >> Decode.maybe)


pullRequests : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, states : OptionalArgument (List Github.Enum.PullRequestState.PullRequestState), labels : OptionalArgument (List String), headRefName : OptionalArgument String, baseRefName : OptionalArgument String, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, states : OptionalArgument (List Github.Enum.PullRequestState.PullRequestState), labels : OptionalArgument (List String), headRefName : OptionalArgument String, baseRefName : OptionalArgument String, orderBy : OptionalArgument Value }) -> SelectionSet pullRequests Github.Object.PullRequestConnection -> FieldDecoder pullRequests Github.Object.Repository
pullRequests fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, states = Absent, labels = Absent, headRefName = Absent, baseRefName = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "states" filledInOptionals.states (Encode.enum toString |> Encode.list), Argument.optional "labels" filledInOptionals.labels (Encode.string |> Encode.list), Argument.optional "headRefName" filledInOptionals.headRefName Encode.string, Argument.optional "baseRefName" filledInOptionals.baseRefName Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "pullRequests" optionalArgs object identity


pushedAt : FieldDecoder (Maybe String) Github.Object.Repository
pushedAt =
    Object.fieldDecoder "pushedAt" [] (Decode.string |> Decode.maybe)


ref : { qualifiedName : String } -> SelectionSet ref Github.Object.Ref -> FieldDecoder (Maybe ref) Github.Object.Repository
ref requiredArgs object =
    Object.selectionFieldDecoder "ref" [ Argument.required "qualifiedName" (requiredArgs.qualifiedName |> Encode.string) ] object (identity >> Decode.maybe)


refs : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, direction : OptionalArgument Github.Enum.OrderDirection.OrderDirection, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, direction : OptionalArgument Github.Enum.OrderDirection.OrderDirection, orderBy : OptionalArgument Value }) -> { refPrefix : String } -> SelectionSet refs Github.Object.RefConnection -> FieldDecoder (Maybe refs) Github.Object.Repository
refs fillInOptionals requiredArgs object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, direction = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "direction" filledInOptionals.direction (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "refs" (optionalArgs ++ [ Argument.required "refPrefix" (requiredArgs.refPrefix |> Encode.string) ]) object (identity >> Decode.maybe)


release : { tagName : String } -> SelectionSet release Github.Object.Release -> FieldDecoder (Maybe release) Github.Object.Repository
release requiredArgs object =
    Object.selectionFieldDecoder "release" [ Argument.required "tagName" (requiredArgs.tagName |> Encode.string) ] object (identity >> Decode.maybe)


releases : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value }) -> SelectionSet releases Github.Object.ReleaseConnection -> FieldDecoder releases Github.Object.Repository
releases fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "releases" optionalArgs object identity


repositoryTopics : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet repositoryTopics Github.Object.RepositoryTopicConnection -> FieldDecoder repositoryTopics Github.Object.Repository
repositoryTopics fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "repositoryTopics" optionalArgs object identity


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
    Object.selectionFieldDecoder "stargazers" optionalArgs object identity


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
    Object.selectionFieldDecoder "watchers" optionalArgs object identity
