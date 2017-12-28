module Github.Object.Issue exposing (..)

import Github.Enum.CommentAuthorAssociation
import Github.Enum.CommentCannotUpdateReason
import Github.Enum.IssueState
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


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Issue
selection constructor =
    Object.object constructor


assignees : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet assignees Github.Object.UserConnection -> FieldDecoder assignees Github.Object.Issue
assignees fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "assignees" optionalArgs object identity


author : SelectionSet author Github.Object.Actor -> FieldDecoder author Github.Object.Issue
author object =
    Object.selectionFieldDecoder "author" [] object identity


authorAssociation : FieldDecoder Github.Enum.CommentAuthorAssociation.CommentAuthorAssociation Github.Object.Issue
authorAssociation =
    Object.fieldDecoder "authorAssociation" [] Github.Enum.CommentAuthorAssociation.decoder


body : FieldDecoder String Github.Object.Issue
body =
    Object.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Github.Object.Issue
bodyHTML =
    Object.fieldDecoder "bodyHTML" [] Decode.string


bodyText : FieldDecoder String Github.Object.Issue
bodyText =
    Object.fieldDecoder "bodyText" [] Decode.string


closed : FieldDecoder Bool Github.Object.Issue
closed =
    Object.fieldDecoder "closed" [] Decode.bool


closedAt : FieldDecoder String Github.Object.Issue
closedAt =
    Object.fieldDecoder "closedAt" [] Decode.string


comments : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet comments Github.Object.IssueCommentConnection -> FieldDecoder comments Github.Object.Issue
comments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "comments" optionalArgs object identity


createdAt : FieldDecoder String Github.Object.Issue
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


createdViaEmail : FieldDecoder Bool Github.Object.Issue
createdViaEmail =
    Object.fieldDecoder "createdViaEmail" [] Decode.bool


databaseId : FieldDecoder Int Github.Object.Issue
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


editor : SelectionSet editor Github.Object.Actor -> FieldDecoder editor Github.Object.Issue
editor object =
    Object.selectionFieldDecoder "editor" [] object identity


id : FieldDecoder String Github.Object.Issue
id =
    Object.fieldDecoder "id" [] Decode.string


labels : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet labels Github.Object.LabelConnection -> FieldDecoder labels Github.Object.Issue
labels fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "labels" optionalArgs object identity


lastEditedAt : FieldDecoder String Github.Object.Issue
lastEditedAt =
    Object.fieldDecoder "lastEditedAt" [] Decode.string


locked : FieldDecoder Bool Github.Object.Issue
locked =
    Object.fieldDecoder "locked" [] Decode.bool


milestone : SelectionSet milestone Github.Object.Milestone -> FieldDecoder milestone Github.Object.Issue
milestone object =
    Object.selectionFieldDecoder "milestone" [] object identity


number : FieldDecoder Int Github.Object.Issue
number =
    Object.fieldDecoder "number" [] Decode.int


participants : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet participants Github.Object.UserConnection -> FieldDecoder participants Github.Object.Issue
participants fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "participants" optionalArgs object identity


projectCards : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet projectCards Github.Object.ProjectCardConnection -> FieldDecoder projectCards Github.Object.Issue
projectCards fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "projectCards" optionalArgs object identity


publishedAt : FieldDecoder String Github.Object.Issue
publishedAt =
    Object.fieldDecoder "publishedAt" [] Decode.string


reactionGroups : SelectionSet reactionGroups Github.Object.ReactionGroup -> FieldDecoder (List reactionGroups) Github.Object.Issue
reactionGroups object =
    Object.selectionFieldDecoder "reactionGroups" [] object (identity >> Decode.list)


reactions : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, content : OptionalArgument Github.Enum.ReactionContent.ReactionContent, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, content : OptionalArgument Github.Enum.ReactionContent.ReactionContent, orderBy : OptionalArgument Value }) -> SelectionSet reactions Github.Object.ReactionConnection -> FieldDecoder reactions Github.Object.Issue
reactions fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, content = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "content" filledInOptionals.content (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "reactions" optionalArgs object identity


repository : SelectionSet repository Github.Object.Repository -> FieldDecoder repository Github.Object.Issue
repository object =
    Object.selectionFieldDecoder "repository" [] object identity


resourcePath : FieldDecoder String Github.Object.Issue
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


state : FieldDecoder Github.Enum.IssueState.IssueState Github.Object.Issue
state =
    Object.fieldDecoder "state" [] Github.Enum.IssueState.decoder


timeline : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, since : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, since : OptionalArgument String }) -> SelectionSet timeline Github.Object.IssueTimelineConnection -> FieldDecoder timeline Github.Object.Issue
timeline fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, since = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "since" filledInOptionals.since Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "timeline" optionalArgs object identity


title : FieldDecoder String Github.Object.Issue
title =
    Object.fieldDecoder "title" [] Decode.string


updatedAt : FieldDecoder String Github.Object.Issue
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Github.Object.Issue
url =
    Object.fieldDecoder "url" [] Decode.string


viewerCanReact : FieldDecoder Bool Github.Object.Issue
viewerCanReact =
    Object.fieldDecoder "viewerCanReact" [] Decode.bool


viewerCanSubscribe : FieldDecoder Bool Github.Object.Issue
viewerCanSubscribe =
    Object.fieldDecoder "viewerCanSubscribe" [] Decode.bool


viewerCanUpdate : FieldDecoder Bool Github.Object.Issue
viewerCanUpdate =
    Object.fieldDecoder "viewerCanUpdate" [] Decode.bool


viewerCannotUpdateReasons : FieldDecoder (List Github.Enum.CommentCannotUpdateReason.CommentCannotUpdateReason) Github.Object.Issue
viewerCannotUpdateReasons =
    Object.fieldDecoder "viewerCannotUpdateReasons" [] (Github.Enum.CommentCannotUpdateReason.decoder |> Decode.list)


viewerDidAuthor : FieldDecoder Bool Github.Object.Issue
viewerDidAuthor =
    Object.fieldDecoder "viewerDidAuthor" [] Decode.bool


viewerSubscription : FieldDecoder Github.Enum.SubscriptionState.SubscriptionState Github.Object.Issue
viewerSubscription =
    Object.fieldDecoder "viewerSubscription" [] Github.Enum.SubscriptionState.decoder
