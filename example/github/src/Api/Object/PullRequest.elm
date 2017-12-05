module Api.Object.PullRequest exposing (..)

import Api.Enum.CommentAuthorAssociation
import Api.Enum.MergeableState
import Api.Enum.PullRequestState
import Api.Enum.SubscriptionState
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PullRequest
build constructor =
    Object.object constructor


additions : FieldDecoder Int Api.Object.PullRequest
additions =
    Field.fieldDecoder "additions" [] Decode.int


assignees : Object assignees Api.Object.UserConnection -> FieldDecoder assignees Api.Object.PullRequest
assignees object =
    Object.single "assignees" [] object


author : Object author Api.Object.Actor -> FieldDecoder author Api.Object.PullRequest
author object =
    Object.single "author" [] object


authorAssociation : FieldDecoder Api.Enum.CommentAuthorAssociation.CommentAuthorAssociation Api.Object.PullRequest
authorAssociation =
    Field.fieldDecoder "authorAssociation" [] Api.Enum.CommentAuthorAssociation.decoder


baseRef : Object baseRef Api.Object.Ref -> FieldDecoder baseRef Api.Object.PullRequest
baseRef object =
    Object.single "baseRef" [] object


baseRefName : FieldDecoder String Api.Object.PullRequest
baseRefName =
    Field.fieldDecoder "baseRefName" [] Decode.string


body : FieldDecoder String Api.Object.PullRequest
body =
    Field.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Api.Object.PullRequest
bodyHTML =
    Field.fieldDecoder "bodyHTML" [] Decode.string


bodyText : FieldDecoder String Api.Object.PullRequest
bodyText =
    Field.fieldDecoder "bodyText" [] Decode.string


changedFiles : FieldDecoder Int Api.Object.PullRequest
changedFiles =
    Field.fieldDecoder "changedFiles" [] Decode.int


closed : FieldDecoder Bool Api.Object.PullRequest
closed =
    Field.fieldDecoder "closed" [] Decode.bool


closedAt : FieldDecoder String Api.Object.PullRequest
closedAt =
    Field.fieldDecoder "closedAt" [] Decode.string


comments : Object comments Api.Object.IssueCommentConnection -> FieldDecoder comments Api.Object.PullRequest
comments object =
    Object.single "comments" [] object


commits : Object commits Api.Object.PullRequestCommitConnection -> FieldDecoder commits Api.Object.PullRequest
commits object =
    Object.single "commits" [] object


createdAt : FieldDecoder String Api.Object.PullRequest
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


createdViaEmail : FieldDecoder Bool Api.Object.PullRequest
createdViaEmail =
    Field.fieldDecoder "createdViaEmail" [] Decode.bool


databaseId : FieldDecoder Int Api.Object.PullRequest
databaseId =
    Field.fieldDecoder "databaseId" [] Decode.int


deletions : FieldDecoder Int Api.Object.PullRequest
deletions =
    Field.fieldDecoder "deletions" [] Decode.int


editor : Object editor Api.Object.Actor -> FieldDecoder editor Api.Object.PullRequest
editor object =
    Object.single "editor" [] object


headRef : Object headRef Api.Object.Ref -> FieldDecoder headRef Api.Object.PullRequest
headRef object =
    Object.single "headRef" [] object


headRefName : FieldDecoder String Api.Object.PullRequest
headRefName =
    Field.fieldDecoder "headRefName" [] Decode.string


headRepository : Object headRepository Api.Object.Repository -> FieldDecoder headRepository Api.Object.PullRequest
headRepository object =
    Object.single "headRepository" [] object


headRepositoryOwner : Object headRepositoryOwner Api.Object.RepositoryOwner -> FieldDecoder headRepositoryOwner Api.Object.PullRequest
headRepositoryOwner object =
    Object.single "headRepositoryOwner" [] object


id : FieldDecoder String Api.Object.PullRequest
id =
    Field.fieldDecoder "id" [] Decode.string


isCrossRepository : FieldDecoder Bool Api.Object.PullRequest
isCrossRepository =
    Field.fieldDecoder "isCrossRepository" [] Decode.bool


labels : Object labels Api.Object.LabelConnection -> FieldDecoder labels Api.Object.PullRequest
labels object =
    Object.single "labels" [] object


lastEditedAt : FieldDecoder String Api.Object.PullRequest
lastEditedAt =
    Field.fieldDecoder "lastEditedAt" [] Decode.string


locked : FieldDecoder Bool Api.Object.PullRequest
locked =
    Field.fieldDecoder "locked" [] Decode.bool


mergeCommit : Object mergeCommit Api.Object.Commit -> FieldDecoder mergeCommit Api.Object.PullRequest
mergeCommit object =
    Object.single "mergeCommit" [] object


mergeable : FieldDecoder Api.Enum.MergeableState.MergeableState Api.Object.PullRequest
mergeable =
    Field.fieldDecoder "mergeable" [] Api.Enum.MergeableState.decoder


merged : FieldDecoder Bool Api.Object.PullRequest
merged =
    Field.fieldDecoder "merged" [] Decode.bool


mergedAt : FieldDecoder String Api.Object.PullRequest
mergedAt =
    Field.fieldDecoder "mergedAt" [] Decode.string


milestone : Object milestone Api.Object.Milestone -> FieldDecoder milestone Api.Object.PullRequest
milestone object =
    Object.single "milestone" [] object


number : FieldDecoder Int Api.Object.PullRequest
number =
    Field.fieldDecoder "number" [] Decode.int


participants : Object participants Api.Object.UserConnection -> FieldDecoder participants Api.Object.PullRequest
participants object =
    Object.single "participants" [] object


potentialMergeCommit : Object potentialMergeCommit Api.Object.Commit -> FieldDecoder potentialMergeCommit Api.Object.PullRequest
potentialMergeCommit object =
    Object.single "potentialMergeCommit" [] object


projectCards : Object projectCards Api.Object.ProjectCardConnection -> FieldDecoder projectCards Api.Object.PullRequest
projectCards object =
    Object.single "projectCards" [] object


publishedAt : FieldDecoder String Api.Object.PullRequest
publishedAt =
    Field.fieldDecoder "publishedAt" [] Decode.string


reactionGroups : Object reactionGroups Api.Object.ReactionGroup -> FieldDecoder (List reactionGroups) Api.Object.PullRequest
reactionGroups object =
    Object.listOf "reactionGroups" [] object


reactions : Object reactions Api.Object.ReactionConnection -> FieldDecoder reactions Api.Object.PullRequest
reactions object =
    Object.single "reactions" [] object


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.PullRequest
repository object =
    Object.single "repository" [] object


resourcePath : FieldDecoder String Api.Object.PullRequest
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


revertResourcePath : FieldDecoder String Api.Object.PullRequest
revertResourcePath =
    Field.fieldDecoder "revertResourcePath" [] Decode.string


revertUrl : FieldDecoder String Api.Object.PullRequest
revertUrl =
    Field.fieldDecoder "revertUrl" [] Decode.string


reviewRequests : Object reviewRequests Api.Object.ReviewRequestConnection -> FieldDecoder reviewRequests Api.Object.PullRequest
reviewRequests object =
    Object.single "reviewRequests" [] object


reviews : Object reviews Api.Object.PullRequestReviewConnection -> FieldDecoder reviews Api.Object.PullRequest
reviews object =
    Object.single "reviews" [] object


state : FieldDecoder Api.Enum.PullRequestState.PullRequestState Api.Object.PullRequest
state =
    Field.fieldDecoder "state" [] Api.Enum.PullRequestState.decoder


suggestedReviewers : Object suggestedReviewers Api.Object.SuggestedReviewer -> FieldDecoder (List suggestedReviewers) Api.Object.PullRequest
suggestedReviewers object =
    Object.listOf "suggestedReviewers" [] object


timeline : Object timeline Api.Object.PullRequestTimelineConnection -> FieldDecoder timeline Api.Object.PullRequest
timeline object =
    Object.single "timeline" [] object


title : FieldDecoder String Api.Object.PullRequest
title =
    Field.fieldDecoder "title" [] Decode.string


updatedAt : FieldDecoder String Api.Object.PullRequest
updatedAt =
    Field.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.PullRequest
url =
    Field.fieldDecoder "url" [] Decode.string


viewerCanReact : FieldDecoder Bool Api.Object.PullRequest
viewerCanReact =
    Field.fieldDecoder "viewerCanReact" [] Decode.bool


viewerCanSubscribe : FieldDecoder Bool Api.Object.PullRequest
viewerCanSubscribe =
    Field.fieldDecoder "viewerCanSubscribe" [] Decode.bool


viewerCanUpdate : FieldDecoder Bool Api.Object.PullRequest
viewerCanUpdate =
    Field.fieldDecoder "viewerCanUpdate" [] Decode.bool


viewerCannotUpdateReasons : FieldDecoder (List String) Api.Object.PullRequest
viewerCannotUpdateReasons =
    Field.fieldDecoder "viewerCannotUpdateReasons" [] (Decode.string |> Decode.list)


viewerDidAuthor : FieldDecoder Bool Api.Object.PullRequest
viewerDidAuthor =
    Field.fieldDecoder "viewerDidAuthor" [] Decode.bool


viewerSubscription : FieldDecoder Api.Enum.SubscriptionState.SubscriptionState Api.Object.PullRequest
viewerSubscription =
    Field.fieldDecoder "viewerSubscription" [] Api.Enum.SubscriptionState.decoder
