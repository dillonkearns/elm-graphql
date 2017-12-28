module Github.Object.PullRequest exposing (..)

import Github.Enum.CommentAuthorAssociation
import Github.Enum.CommentCannotUpdateReason
import Github.Enum.MergeableState
import Github.Enum.PullRequestReviewState
import Github.Enum.PullRequestState
import Github.Enum.ReactionContent
import Github.Enum.SubscriptionState
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.PullRequest
selection constructor =
    Object.object constructor


additions : FieldDecoder Int Github.Object.PullRequest
additions =
    Object.fieldDecoder "additions" [] Decode.int


assignees : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet assignees Github.Object.UserConnection -> FieldDecoder assignees Github.Object.PullRequest
assignees fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "assignees" optionalArgs object identity


author : SelectionSet author Github.Object.Actor -> FieldDecoder author Github.Object.PullRequest
author object =
    Object.selectionFieldDecoder "author" [] object identity


authorAssociation : FieldDecoder Github.Enum.CommentAuthorAssociation.CommentAuthorAssociation Github.Object.PullRequest
authorAssociation =
    Object.fieldDecoder "authorAssociation" [] Github.Enum.CommentAuthorAssociation.decoder


baseRef : SelectionSet baseRef Github.Object.Ref -> FieldDecoder baseRef Github.Object.PullRequest
baseRef object =
    Object.selectionFieldDecoder "baseRef" [] object identity


baseRefName : FieldDecoder String Github.Object.PullRequest
baseRefName =
    Object.fieldDecoder "baseRefName" [] Decode.string


body : FieldDecoder String Github.Object.PullRequest
body =
    Object.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Github.Object.PullRequest
bodyHTML =
    Object.fieldDecoder "bodyHTML" [] Decode.string


bodyText : FieldDecoder String Github.Object.PullRequest
bodyText =
    Object.fieldDecoder "bodyText" [] Decode.string


changedFiles : FieldDecoder Int Github.Object.PullRequest
changedFiles =
    Object.fieldDecoder "changedFiles" [] Decode.int


closed : FieldDecoder Bool Github.Object.PullRequest
closed =
    Object.fieldDecoder "closed" [] Decode.bool


closedAt : FieldDecoder String Github.Object.PullRequest
closedAt =
    Object.fieldDecoder "closedAt" [] Decode.string


comments : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet comments Github.Object.IssueCommentConnection -> FieldDecoder comments Github.Object.PullRequest
comments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "comments" optionalArgs object identity


commits : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet commits Github.Object.PullRequestCommitConnection -> FieldDecoder commits Github.Object.PullRequest
commits fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "commits" optionalArgs object identity


createdAt : FieldDecoder String Github.Object.PullRequest
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


createdViaEmail : FieldDecoder Bool Github.Object.PullRequest
createdViaEmail =
    Object.fieldDecoder "createdViaEmail" [] Decode.bool


databaseId : FieldDecoder Int Github.Object.PullRequest
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


deletions : FieldDecoder Int Github.Object.PullRequest
deletions =
    Object.fieldDecoder "deletions" [] Decode.int


editor : SelectionSet editor Github.Object.Actor -> FieldDecoder editor Github.Object.PullRequest
editor object =
    Object.selectionFieldDecoder "editor" [] object identity


headRef : SelectionSet headRef Github.Object.Ref -> FieldDecoder headRef Github.Object.PullRequest
headRef object =
    Object.selectionFieldDecoder "headRef" [] object identity


headRefName : FieldDecoder String Github.Object.PullRequest
headRefName =
    Object.fieldDecoder "headRefName" [] Decode.string


headRepository : SelectionSet headRepository Github.Object.Repository -> FieldDecoder headRepository Github.Object.PullRequest
headRepository object =
    Object.selectionFieldDecoder "headRepository" [] object identity


headRepositoryOwner : SelectionSet headRepositoryOwner Github.Object.RepositoryOwner -> FieldDecoder headRepositoryOwner Github.Object.PullRequest
headRepositoryOwner object =
    Object.selectionFieldDecoder "headRepositoryOwner" [] object identity


id : FieldDecoder String Github.Object.PullRequest
id =
    Object.fieldDecoder "id" [] Decode.string


isCrossRepository : FieldDecoder Bool Github.Object.PullRequest
isCrossRepository =
    Object.fieldDecoder "isCrossRepository" [] Decode.bool


labels : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet labels Github.Object.LabelConnection -> FieldDecoder labels Github.Object.PullRequest
labels fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "labels" optionalArgs object identity


lastEditedAt : FieldDecoder String Github.Object.PullRequest
lastEditedAt =
    Object.fieldDecoder "lastEditedAt" [] Decode.string


locked : FieldDecoder Bool Github.Object.PullRequest
locked =
    Object.fieldDecoder "locked" [] Decode.bool


mergeCommit : SelectionSet mergeCommit Github.Object.Commit -> FieldDecoder mergeCommit Github.Object.PullRequest
mergeCommit object =
    Object.selectionFieldDecoder "mergeCommit" [] object identity


mergeable : FieldDecoder Github.Enum.MergeableState.MergeableState Github.Object.PullRequest
mergeable =
    Object.fieldDecoder "mergeable" [] Github.Enum.MergeableState.decoder


merged : FieldDecoder Bool Github.Object.PullRequest
merged =
    Object.fieldDecoder "merged" [] Decode.bool


mergedAt : FieldDecoder String Github.Object.PullRequest
mergedAt =
    Object.fieldDecoder "mergedAt" [] Decode.string


milestone : SelectionSet milestone Github.Object.Milestone -> FieldDecoder milestone Github.Object.PullRequest
milestone object =
    Object.selectionFieldDecoder "milestone" [] object identity


number : FieldDecoder Int Github.Object.PullRequest
number =
    Object.fieldDecoder "number" [] Decode.int


participants : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet participants Github.Object.UserConnection -> FieldDecoder participants Github.Object.PullRequest
participants fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "participants" optionalArgs object identity


potentialMergeCommit : SelectionSet potentialMergeCommit Github.Object.Commit -> FieldDecoder potentialMergeCommit Github.Object.PullRequest
potentialMergeCommit object =
    Object.selectionFieldDecoder "potentialMergeCommit" [] object identity


projectCards : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet projectCards Github.Object.ProjectCardConnection -> FieldDecoder projectCards Github.Object.PullRequest
projectCards fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "projectCards" optionalArgs object identity


publishedAt : FieldDecoder String Github.Object.PullRequest
publishedAt =
    Object.fieldDecoder "publishedAt" [] Decode.string


reactionGroups : SelectionSet reactionGroups Github.Object.ReactionGroup -> FieldDecoder (List reactionGroups) Github.Object.PullRequest
reactionGroups object =
    Object.selectionFieldDecoder "reactionGroups" [] object (identity >> Decode.list)


reactions : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, content : OptionalArgument Github.Enum.ReactionContent.ReactionContent, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, content : OptionalArgument Github.Enum.ReactionContent.ReactionContent, orderBy : OptionalArgument Value }) -> SelectionSet reactions Github.Object.ReactionConnection -> FieldDecoder reactions Github.Object.PullRequest
reactions fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, content = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "content" filledInOptionals.content (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "reactions" optionalArgs object identity


repository : SelectionSet repository Github.Object.Repository -> FieldDecoder repository Github.Object.PullRequest
repository object =
    Object.selectionFieldDecoder "repository" [] object identity


resourcePath : FieldDecoder String Github.Object.PullRequest
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


revertResourcePath : FieldDecoder String Github.Object.PullRequest
revertResourcePath =
    Object.fieldDecoder "revertResourcePath" [] Decode.string


revertUrl : FieldDecoder String Github.Object.PullRequest
revertUrl =
    Object.fieldDecoder "revertUrl" [] Decode.string


reviewRequests : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet reviewRequests Github.Object.ReviewRequestConnection -> FieldDecoder reviewRequests Github.Object.PullRequest
reviewRequests fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "reviewRequests" optionalArgs object identity


reviews : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, states : OptionalArgument (List Github.Enum.PullRequestReviewState.PullRequestReviewState), author : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, states : OptionalArgument (List Github.Enum.PullRequestReviewState.PullRequestReviewState), author : OptionalArgument String }) -> SelectionSet reviews Github.Object.PullRequestReviewConnection -> FieldDecoder reviews Github.Object.PullRequest
reviews fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, states = Absent, author = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "states" filledInOptionals.states (Encode.enum toString |> Encode.list), Argument.optional "author" filledInOptionals.author Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "reviews" optionalArgs object identity


state : FieldDecoder Github.Enum.PullRequestState.PullRequestState Github.Object.PullRequest
state =
    Object.fieldDecoder "state" [] Github.Enum.PullRequestState.decoder


suggestedReviewers : SelectionSet suggestedReviewers Github.Object.SuggestedReviewer -> FieldDecoder (List suggestedReviewers) Github.Object.PullRequest
suggestedReviewers object =
    Object.selectionFieldDecoder "suggestedReviewers" [] object (identity >> Decode.list)


timeline : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, since : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, since : OptionalArgument String }) -> SelectionSet timeline Github.Object.PullRequestTimelineConnection -> FieldDecoder timeline Github.Object.PullRequest
timeline fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, since = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "since" filledInOptionals.since Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "timeline" optionalArgs object identity


title : FieldDecoder String Github.Object.PullRequest
title =
    Object.fieldDecoder "title" [] Decode.string


updatedAt : FieldDecoder String Github.Object.PullRequest
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Github.Object.PullRequest
url =
    Object.fieldDecoder "url" [] Decode.string


viewerCanReact : FieldDecoder Bool Github.Object.PullRequest
viewerCanReact =
    Object.fieldDecoder "viewerCanReact" [] Decode.bool


viewerCanSubscribe : FieldDecoder Bool Github.Object.PullRequest
viewerCanSubscribe =
    Object.fieldDecoder "viewerCanSubscribe" [] Decode.bool


viewerCanUpdate : FieldDecoder Bool Github.Object.PullRequest
viewerCanUpdate =
    Object.fieldDecoder "viewerCanUpdate" [] Decode.bool


viewerCannotUpdateReasons : FieldDecoder (List Github.Enum.CommentCannotUpdateReason.CommentCannotUpdateReason) Github.Object.PullRequest
viewerCannotUpdateReasons =
    Object.fieldDecoder "viewerCannotUpdateReasons" [] (Github.Enum.CommentCannotUpdateReason.decoder |> Decode.list)


viewerDidAuthor : FieldDecoder Bool Github.Object.PullRequest
viewerDidAuthor =
    Object.fieldDecoder "viewerDidAuthor" [] Decode.bool


viewerSubscription : FieldDecoder Github.Enum.SubscriptionState.SubscriptionState Github.Object.PullRequest
viewerSubscription =
    Object.fieldDecoder "viewerSubscription" [] Github.Enum.SubscriptionState.decoder
