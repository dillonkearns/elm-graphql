module Api.Object.PullRequest exposing (..)

import Api.Enum.CommentAuthorAssociation
import Api.Enum.MergeableState
import Api.Enum.PullRequestReviewState
import Api.Enum.PullRequestState
import Api.Enum.ReactionContent
import Api.Enum.SubscriptionState
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PullRequest
build constructor =
    Object.object constructor


additions : FieldDecoder Int Api.Object.PullRequest
additions =
    Object.fieldDecoder "additions" [] Decode.int


assignees : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object assignees Api.Object.UserConnection -> FieldDecoder assignees Api.Object.PullRequest
assignees fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string ]
                |> List.filterMap identity
    in
    Object.single "assignees" optionalArgs object


author : Object author Api.Object.Actor -> FieldDecoder author Api.Object.PullRequest
author object =
    Object.single "author" [] object


authorAssociation : FieldDecoder Api.Enum.CommentAuthorAssociation.CommentAuthorAssociation Api.Object.PullRequest
authorAssociation =
    Object.fieldDecoder "authorAssociation" [] Api.Enum.CommentAuthorAssociation.decoder


baseRef : Object baseRef Api.Object.Ref -> FieldDecoder baseRef Api.Object.PullRequest
baseRef object =
    Object.single "baseRef" [] object


baseRefName : FieldDecoder String Api.Object.PullRequest
baseRefName =
    Object.fieldDecoder "baseRefName" [] Decode.string


body : FieldDecoder String Api.Object.PullRequest
body =
    Object.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Api.Object.PullRequest
bodyHTML =
    Object.fieldDecoder "bodyHTML" [] Decode.string


bodyText : FieldDecoder String Api.Object.PullRequest
bodyText =
    Object.fieldDecoder "bodyText" [] Decode.string


changedFiles : FieldDecoder Int Api.Object.PullRequest
changedFiles =
    Object.fieldDecoder "changedFiles" [] Decode.int


closed : FieldDecoder Bool Api.Object.PullRequest
closed =
    Object.fieldDecoder "closed" [] Decode.bool


closedAt : FieldDecoder String Api.Object.PullRequest
closedAt =
    Object.fieldDecoder "closedAt" [] Decode.string


comments : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object comments Api.Object.IssueCommentConnection -> FieldDecoder comments Api.Object.PullRequest
comments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string ]
                |> List.filterMap identity
    in
    Object.single "comments" optionalArgs object


commits : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object commits Api.Object.PullRequestCommitConnection -> FieldDecoder commits Api.Object.PullRequest
commits fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string ]
                |> List.filterMap identity
    in
    Object.single "commits" optionalArgs object


createdAt : FieldDecoder String Api.Object.PullRequest
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


createdViaEmail : FieldDecoder Bool Api.Object.PullRequest
createdViaEmail =
    Object.fieldDecoder "createdViaEmail" [] Decode.bool


databaseId : FieldDecoder Int Api.Object.PullRequest
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


deletions : FieldDecoder Int Api.Object.PullRequest
deletions =
    Object.fieldDecoder "deletions" [] Decode.int


editor : Object editor Api.Object.Actor -> FieldDecoder editor Api.Object.PullRequest
editor object =
    Object.single "editor" [] object


headRef : Object headRef Api.Object.Ref -> FieldDecoder headRef Api.Object.PullRequest
headRef object =
    Object.single "headRef" [] object


headRefName : FieldDecoder String Api.Object.PullRequest
headRefName =
    Object.fieldDecoder "headRefName" [] Decode.string


headRepository : Object headRepository Api.Object.Repository -> FieldDecoder headRepository Api.Object.PullRequest
headRepository object =
    Object.single "headRepository" [] object


headRepositoryOwner : Object headRepositoryOwner Api.Object.RepositoryOwner -> FieldDecoder headRepositoryOwner Api.Object.PullRequest
headRepositoryOwner object =
    Object.single "headRepositoryOwner" [] object


id : FieldDecoder String Api.Object.PullRequest
id =
    Object.fieldDecoder "id" [] Decode.string


isCrossRepository : FieldDecoder Bool Api.Object.PullRequest
isCrossRepository =
    Object.fieldDecoder "isCrossRepository" [] Decode.bool


labels : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object labels Api.Object.LabelConnection -> FieldDecoder labels Api.Object.PullRequest
labels fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string ]
                |> List.filterMap identity
    in
    Object.single "labels" optionalArgs object


lastEditedAt : FieldDecoder String Api.Object.PullRequest
lastEditedAt =
    Object.fieldDecoder "lastEditedAt" [] Decode.string


locked : FieldDecoder Bool Api.Object.PullRequest
locked =
    Object.fieldDecoder "locked" [] Decode.bool


mergeCommit : Object mergeCommit Api.Object.Commit -> FieldDecoder mergeCommit Api.Object.PullRequest
mergeCommit object =
    Object.single "mergeCommit" [] object


mergeable : FieldDecoder Api.Enum.MergeableState.MergeableState Api.Object.PullRequest
mergeable =
    Object.fieldDecoder "mergeable" [] Api.Enum.MergeableState.decoder


merged : FieldDecoder Bool Api.Object.PullRequest
merged =
    Object.fieldDecoder "merged" [] Decode.bool


mergedAt : FieldDecoder String Api.Object.PullRequest
mergedAt =
    Object.fieldDecoder "mergedAt" [] Decode.string


milestone : Object milestone Api.Object.Milestone -> FieldDecoder milestone Api.Object.PullRequest
milestone object =
    Object.single "milestone" [] object


number : FieldDecoder Int Api.Object.PullRequest
number =
    Object.fieldDecoder "number" [] Decode.int


participants : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object participants Api.Object.UserConnection -> FieldDecoder participants Api.Object.PullRequest
participants fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string ]
                |> List.filterMap identity
    in
    Object.single "participants" optionalArgs object


potentialMergeCommit : Object potentialMergeCommit Api.Object.Commit -> FieldDecoder potentialMergeCommit Api.Object.PullRequest
potentialMergeCommit object =
    Object.single "potentialMergeCommit" [] object


projectCards : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object projectCards Api.Object.ProjectCardConnection -> FieldDecoder projectCards Api.Object.PullRequest
projectCards fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string ]
                |> List.filterMap identity
    in
    Object.single "projectCards" optionalArgs object


publishedAt : FieldDecoder String Api.Object.PullRequest
publishedAt =
    Object.fieldDecoder "publishedAt" [] Decode.string


reactionGroups : Object reactionGroups Api.Object.ReactionGroup -> FieldDecoder (List reactionGroups) Api.Object.PullRequest
reactionGroups object =
    Object.listOf "reactionGroups" [] object


reactions : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, content : Maybe Api.Enum.ReactionContent.ReactionContent, orderBy : Maybe Value } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, content : Maybe Api.Enum.ReactionContent.ReactionContent, orderBy : Maybe Value }) -> Object reactions Api.Object.ReactionConnection -> FieldDecoder reactions Api.Object.PullRequest
reactions fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, content = Nothing, orderBy = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string, Argument.optional "content" filledInOptionals.content (Value.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "reactions" optionalArgs object


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.PullRequest
repository object =
    Object.single "repository" [] object


resourcePath : FieldDecoder String Api.Object.PullRequest
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


revertResourcePath : FieldDecoder String Api.Object.PullRequest
revertResourcePath =
    Object.fieldDecoder "revertResourcePath" [] Decode.string


revertUrl : FieldDecoder String Api.Object.PullRequest
revertUrl =
    Object.fieldDecoder "revertUrl" [] Decode.string


reviewRequests : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object reviewRequests Api.Object.ReviewRequestConnection -> FieldDecoder reviewRequests Api.Object.PullRequest
reviewRequests fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string ]
                |> List.filterMap identity
    in
    Object.single "reviewRequests" optionalArgs object


reviews : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, states : Maybe (List Api.Enum.PullRequestReviewState.PullRequestReviewState), author : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, states : Maybe (List Api.Enum.PullRequestReviewState.PullRequestReviewState), author : Maybe String }) -> Object reviews Api.Object.PullRequestReviewConnection -> FieldDecoder reviews Api.Object.PullRequest
reviews fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, states = Nothing, author = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string, Argument.optional "states" filledInOptionals.states (Value.enum toString |> Value.list), Argument.optional "author" filledInOptionals.author Value.string ]
                |> List.filterMap identity
    in
    Object.single "reviews" optionalArgs object


state : FieldDecoder Api.Enum.PullRequestState.PullRequestState Api.Object.PullRequest
state =
    Object.fieldDecoder "state" [] Api.Enum.PullRequestState.decoder


suggestedReviewers : Object suggestedReviewers Api.Object.SuggestedReviewer -> FieldDecoder (List suggestedReviewers) Api.Object.PullRequest
suggestedReviewers object =
    Object.listOf "suggestedReviewers" [] object


timeline : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, since : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, since : Maybe String }) -> Object timeline Api.Object.PullRequestTimelineConnection -> FieldDecoder timeline Api.Object.PullRequest
timeline fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, since = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string, Argument.optional "since" filledInOptionals.since Value.string ]
                |> List.filterMap identity
    in
    Object.single "timeline" optionalArgs object


title : FieldDecoder String Api.Object.PullRequest
title =
    Object.fieldDecoder "title" [] Decode.string


updatedAt : FieldDecoder String Api.Object.PullRequest
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.PullRequest
url =
    Object.fieldDecoder "url" [] Decode.string


viewerCanReact : FieldDecoder Bool Api.Object.PullRequest
viewerCanReact =
    Object.fieldDecoder "viewerCanReact" [] Decode.bool


viewerCanSubscribe : FieldDecoder Bool Api.Object.PullRequest
viewerCanSubscribe =
    Object.fieldDecoder "viewerCanSubscribe" [] Decode.bool


viewerCanUpdate : FieldDecoder Bool Api.Object.PullRequest
viewerCanUpdate =
    Object.fieldDecoder "viewerCanUpdate" [] Decode.bool


viewerCannotUpdateReasons : FieldDecoder (List String) Api.Object.PullRequest
viewerCannotUpdateReasons =
    Object.fieldDecoder "viewerCannotUpdateReasons" [] (Decode.string |> Decode.list)


viewerDidAuthor : FieldDecoder Bool Api.Object.PullRequest
viewerDidAuthor =
    Object.fieldDecoder "viewerDidAuthor" [] Decode.bool


viewerSubscription : FieldDecoder Api.Enum.SubscriptionState.SubscriptionState Api.Object.PullRequest
viewerSubscription =
    Object.fieldDecoder "viewerSubscription" [] Api.Enum.SubscriptionState.decoder
