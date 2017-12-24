module Api.Object.Issue exposing (..)

import Api.Enum.CommentAuthorAssociation
import Api.Enum.CommentCannotUpdateReason
import Api.Enum.IssueState
import Api.Enum.ReactionContent
import Api.Enum.SubscriptionState
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.Issue
selection constructor =
    Object.object constructor


assignees : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> SelectionSet assignees Api.Object.UserConnection -> FieldDecoder assignees Api.Object.Issue
assignees fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "assignees" optionalArgs object


author : SelectionSet author Api.Object.Actor -> FieldDecoder author Api.Object.Issue
author object =
    Object.single "author" [] object


authorAssociation : FieldDecoder Api.Enum.CommentAuthorAssociation.CommentAuthorAssociation Api.Object.Issue
authorAssociation =
    Object.fieldDecoder "authorAssociation" [] Api.Enum.CommentAuthorAssociation.decoder


body : FieldDecoder String Api.Object.Issue
body =
    Object.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Api.Object.Issue
bodyHTML =
    Object.fieldDecoder "bodyHTML" [] Decode.string


bodyText : FieldDecoder String Api.Object.Issue
bodyText =
    Object.fieldDecoder "bodyText" [] Decode.string


closed : FieldDecoder Bool Api.Object.Issue
closed =
    Object.fieldDecoder "closed" [] Decode.bool


closedAt : FieldDecoder String Api.Object.Issue
closedAt =
    Object.fieldDecoder "closedAt" [] Decode.string


comments : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> SelectionSet comments Api.Object.IssueCommentConnection -> FieldDecoder comments Api.Object.Issue
comments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "comments" optionalArgs object


createdAt : FieldDecoder String Api.Object.Issue
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


createdViaEmail : FieldDecoder Bool Api.Object.Issue
createdViaEmail =
    Object.fieldDecoder "createdViaEmail" [] Decode.bool


databaseId : FieldDecoder Int Api.Object.Issue
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


editor : SelectionSet editor Api.Object.Actor -> FieldDecoder editor Api.Object.Issue
editor object =
    Object.single "editor" [] object


id : FieldDecoder String Api.Object.Issue
id =
    Object.fieldDecoder "id" [] Decode.string


labels : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> SelectionSet labels Api.Object.LabelConnection -> FieldDecoder labels Api.Object.Issue
labels fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "labels" optionalArgs object


lastEditedAt : FieldDecoder String Api.Object.Issue
lastEditedAt =
    Object.fieldDecoder "lastEditedAt" [] Decode.string


locked : FieldDecoder Bool Api.Object.Issue
locked =
    Object.fieldDecoder "locked" [] Decode.bool


milestone : SelectionSet milestone Api.Object.Milestone -> FieldDecoder milestone Api.Object.Issue
milestone object =
    Object.single "milestone" [] object


number : FieldDecoder Int Api.Object.Issue
number =
    Object.fieldDecoder "number" [] Decode.int


participants : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> SelectionSet participants Api.Object.UserConnection -> FieldDecoder participants Api.Object.Issue
participants fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "participants" optionalArgs object


projectCards : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> SelectionSet projectCards Api.Object.ProjectCardConnection -> FieldDecoder projectCards Api.Object.Issue
projectCards fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "projectCards" optionalArgs object


publishedAt : FieldDecoder String Api.Object.Issue
publishedAt =
    Object.fieldDecoder "publishedAt" [] Decode.string


reactionGroups : SelectionSet reactionGroups Api.Object.ReactionGroup -> FieldDecoder (List reactionGroups) Api.Object.Issue
reactionGroups object =
    Object.listOf "reactionGroups" [] object


reactions : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, content : Maybe Api.Enum.ReactionContent.ReactionContent, orderBy : Maybe Value } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, content : Maybe Api.Enum.ReactionContent.ReactionContent, orderBy : Maybe Value }) -> SelectionSet reactions Api.Object.ReactionConnection -> FieldDecoder reactions Api.Object.Issue
reactions fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, content = Nothing, orderBy = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "content" filledInOptionals.content (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "reactions" optionalArgs object


repository : SelectionSet repository Api.Object.Repository -> FieldDecoder repository Api.Object.Issue
repository object =
    Object.single "repository" [] object


resourcePath : FieldDecoder String Api.Object.Issue
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


state : FieldDecoder Api.Enum.IssueState.IssueState Api.Object.Issue
state =
    Object.fieldDecoder "state" [] Api.Enum.IssueState.decoder


timeline : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, since : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, since : Maybe String }) -> SelectionSet timeline Api.Object.IssueTimelineConnection -> FieldDecoder timeline Api.Object.Issue
timeline fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, since = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "since" filledInOptionals.since Encode.string ]
                |> List.filterMap identity
    in
    Object.single "timeline" optionalArgs object


title : FieldDecoder String Api.Object.Issue
title =
    Object.fieldDecoder "title" [] Decode.string


updatedAt : FieldDecoder String Api.Object.Issue
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.Issue
url =
    Object.fieldDecoder "url" [] Decode.string


viewerCanReact : FieldDecoder Bool Api.Object.Issue
viewerCanReact =
    Object.fieldDecoder "viewerCanReact" [] Decode.bool


viewerCanSubscribe : FieldDecoder Bool Api.Object.Issue
viewerCanSubscribe =
    Object.fieldDecoder "viewerCanSubscribe" [] Decode.bool


viewerCanUpdate : FieldDecoder Bool Api.Object.Issue
viewerCanUpdate =
    Object.fieldDecoder "viewerCanUpdate" [] Decode.bool


viewerCannotUpdateReasons : FieldDecoder (List Api.Enum.CommentCannotUpdateReason.CommentCannotUpdateReason) Api.Object.Issue
viewerCannotUpdateReasons =
    Object.fieldDecoder "viewerCannotUpdateReasons" [] (Api.Enum.CommentCannotUpdateReason.decoder |> Decode.list)


viewerDidAuthor : FieldDecoder Bool Api.Object.Issue
viewerDidAuthor =
    Object.fieldDecoder "viewerDidAuthor" [] Decode.bool


viewerSubscription : FieldDecoder Api.Enum.SubscriptionState.SubscriptionState Api.Object.Issue
viewerSubscription =
    Object.fieldDecoder "viewerSubscription" [] Api.Enum.SubscriptionState.decoder
