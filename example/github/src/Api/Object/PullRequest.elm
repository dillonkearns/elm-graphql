module Api.Object.PullRequest exposing (..)

import Api.Enum.CommentAuthorAssociation
import Api.Enum.CommentCannotUpdateReason
import Api.Enum.MergeableState
import Api.Enum.PullRequestReviewState
import Api.Enum.PullRequestState
import Api.Enum.ReactionContent
import Api.Enum.SubscriptionState
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.PullRequest
selection constructor =
    Object.object constructor


additions : FieldDecoder Int Api.Object.PullRequest
additions =
    Object.fieldDecoder "additions" [] Decode.int


assignees : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet assignees Api.Object.UserConnection -> FieldDecoder assignees Api.Object.PullRequest
assignees fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "assignees" optionalArgs object


author : SelectionSet author Api.Object.Actor -> FieldDecoder author Api.Object.PullRequest
author object =
    Object.single "author" [] object


authorAssociation : FieldDecoder Api.Enum.CommentAuthorAssociation.CommentAuthorAssociation Api.Object.PullRequest
authorAssociation =
    Object.fieldDecoder "authorAssociation" [] Api.Enum.CommentAuthorAssociation.decoder


baseRef : SelectionSet baseRef Api.Object.Ref -> FieldDecoder baseRef Api.Object.PullRequest
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


comments : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet comments Api.Object.IssueCommentConnection -> FieldDecoder comments Api.Object.PullRequest
comments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "comments" optionalArgs object


commits : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet commits Api.Object.PullRequestCommitConnection -> FieldDecoder commits Api.Object.PullRequest
commits fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
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


editor : SelectionSet editor Api.Object.Actor -> FieldDecoder editor Api.Object.PullRequest
editor object =
    Object.single "editor" [] object


headRef : SelectionSet headRef Api.Object.Ref -> FieldDecoder headRef Api.Object.PullRequest
headRef object =
    Object.single "headRef" [] object


headRefName : FieldDecoder String Api.Object.PullRequest
headRefName =
    Object.fieldDecoder "headRefName" [] Decode.string


headRepository : SelectionSet headRepository Api.Object.Repository -> FieldDecoder headRepository Api.Object.PullRequest
headRepository object =
    Object.single "headRepository" [] object


headRepositoryOwner : SelectionSet headRepositoryOwner Api.Object.RepositoryOwner -> FieldDecoder headRepositoryOwner Api.Object.PullRequest
headRepositoryOwner object =
    Object.single "headRepositoryOwner" [] object


id : FieldDecoder String Api.Object.PullRequest
id =
    Object.fieldDecoder "id" [] Decode.string


isCrossRepository : FieldDecoder Bool Api.Object.PullRequest
isCrossRepository =
    Object.fieldDecoder "isCrossRepository" [] Decode.bool


labels : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet labels Api.Object.LabelConnection -> FieldDecoder labels Api.Object.PullRequest
labels fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "labels" optionalArgs object


lastEditedAt : FieldDecoder String Api.Object.PullRequest
lastEditedAt =
    Object.fieldDecoder "lastEditedAt" [] Decode.string


locked : FieldDecoder Bool Api.Object.PullRequest
locked =
    Object.fieldDecoder "locked" [] Decode.bool


mergeCommit : SelectionSet mergeCommit Api.Object.Commit -> FieldDecoder mergeCommit Api.Object.PullRequest
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


milestone : SelectionSet milestone Api.Object.Milestone -> FieldDecoder milestone Api.Object.PullRequest
milestone object =
    Object.single "milestone" [] object


number : FieldDecoder Int Api.Object.PullRequest
number =
    Object.fieldDecoder "number" [] Decode.int


participants : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet participants Api.Object.UserConnection -> FieldDecoder participants Api.Object.PullRequest
participants fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "participants" optionalArgs object


potentialMergeCommit : SelectionSet potentialMergeCommit Api.Object.Commit -> FieldDecoder potentialMergeCommit Api.Object.PullRequest
potentialMergeCommit object =
    Object.single "potentialMergeCommit" [] object


projectCards : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet projectCards Api.Object.ProjectCardConnection -> FieldDecoder projectCards Api.Object.PullRequest
projectCards fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "projectCards" optionalArgs object


publishedAt : FieldDecoder String Api.Object.PullRequest
publishedAt =
    Object.fieldDecoder "publishedAt" [] Decode.string


reactionGroups : SelectionSet reactionGroups Api.Object.ReactionGroup -> FieldDecoder (List reactionGroups) Api.Object.PullRequest
reactionGroups object =
    Object.listOf "reactionGroups" [] object


reactions : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, content : OptionalArgument Api.Enum.ReactionContent.ReactionContent, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, content : OptionalArgument Api.Enum.ReactionContent.ReactionContent, orderBy : OptionalArgument Value }) -> SelectionSet reactions Api.Object.ReactionConnection -> FieldDecoder reactions Api.Object.PullRequest
reactions fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, content = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "content" filledInOptionals.content (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "reactions" optionalArgs object


repository : SelectionSet repository Api.Object.Repository -> FieldDecoder repository Api.Object.PullRequest
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


reviewRequests : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet reviewRequests Api.Object.ReviewRequestConnection -> FieldDecoder reviewRequests Api.Object.PullRequest
reviewRequests fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "reviewRequests" optionalArgs object


reviews : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, states : OptionalArgument (List Api.Enum.PullRequestReviewState.PullRequestReviewState), author : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, states : OptionalArgument (List Api.Enum.PullRequestReviewState.PullRequestReviewState), author : OptionalArgument String }) -> SelectionSet reviews Api.Object.PullRequestReviewConnection -> FieldDecoder reviews Api.Object.PullRequest
reviews fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, states = Absent, author = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "states" filledInOptionals.states (Encode.enum toString |> Encode.list), Argument.optional "author" filledInOptionals.author Encode.string ]
                |> List.filterMap identity
    in
    Object.single "reviews" optionalArgs object


state : FieldDecoder Api.Enum.PullRequestState.PullRequestState Api.Object.PullRequest
state =
    Object.fieldDecoder "state" [] Api.Enum.PullRequestState.decoder


suggestedReviewers : SelectionSet suggestedReviewers Api.Object.SuggestedReviewer -> FieldDecoder (List suggestedReviewers) Api.Object.PullRequest
suggestedReviewers object =
    Object.listOf "suggestedReviewers" [] object


timeline : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, since : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, since : OptionalArgument String }) -> SelectionSet timeline Api.Object.PullRequestTimelineConnection -> FieldDecoder timeline Api.Object.PullRequest
timeline fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, since = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "since" filledInOptionals.since Encode.string ]
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


viewerCannotUpdateReasons : FieldDecoder (List Api.Enum.CommentCannotUpdateReason.CommentCannotUpdateReason) Api.Object.PullRequest
viewerCannotUpdateReasons =
    Object.fieldDecoder "viewerCannotUpdateReasons" [] (Api.Enum.CommentCannotUpdateReason.decoder |> Decode.list)


viewerDidAuthor : FieldDecoder Bool Api.Object.PullRequest
viewerDidAuthor =
    Object.fieldDecoder "viewerDidAuthor" [] Decode.bool


viewerSubscription : FieldDecoder Api.Enum.SubscriptionState.SubscriptionState Api.Object.PullRequest
viewerSubscription =
    Object.fieldDecoder "viewerSubscription" [] Api.Enum.SubscriptionState.decoder
