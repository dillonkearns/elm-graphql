module Api.Object.Issue exposing (..)

import Api.Enum.CommentAuthorAssociation
import Api.Enum.IssueState
import Api.Enum.SubscriptionState
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Issue
build constructor =
    Object.object constructor


assignees : Object assignees Api.Object.UserConnection -> FieldDecoder assignees Api.Object.Issue
assignees object =
    Object.single "assignees" [] object


author : Object author Api.Object.Actor -> FieldDecoder author Api.Object.Issue
author object =
    Object.single "author" [] object


authorAssociation : FieldDecoder Api.Enum.CommentAuthorAssociation.CommentAuthorAssociation Api.Object.Issue
authorAssociation =
    Field.fieldDecoder "authorAssociation" [] Api.Enum.CommentAuthorAssociation.decoder


body : FieldDecoder String Api.Object.Issue
body =
    Field.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Api.Object.Issue
bodyHTML =
    Field.fieldDecoder "bodyHTML" [] Decode.string


bodyText : FieldDecoder String Api.Object.Issue
bodyText =
    Field.fieldDecoder "bodyText" [] Decode.string


closed : FieldDecoder String Api.Object.Issue
closed =
    Field.fieldDecoder "closed" [] Decode.string


closedAt : FieldDecoder String Api.Object.Issue
closedAt =
    Field.fieldDecoder "closedAt" [] Decode.string


comments : Object comments Api.Object.IssueCommentConnection -> FieldDecoder comments Api.Object.Issue
comments object =
    Object.single "comments" [] object


createdAt : FieldDecoder String Api.Object.Issue
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


createdViaEmail : FieldDecoder String Api.Object.Issue
createdViaEmail =
    Field.fieldDecoder "createdViaEmail" [] Decode.string


databaseId : FieldDecoder String Api.Object.Issue
databaseId =
    Field.fieldDecoder "databaseId" [] Decode.string


editor : Object editor Api.Object.Actor -> FieldDecoder editor Api.Object.Issue
editor object =
    Object.single "editor" [] object


id : FieldDecoder String Api.Object.Issue
id =
    Field.fieldDecoder "id" [] Decode.string


labels : Object labels Api.Object.LabelConnection -> FieldDecoder labels Api.Object.Issue
labels object =
    Object.single "labels" [] object


lastEditedAt : FieldDecoder String Api.Object.Issue
lastEditedAt =
    Field.fieldDecoder "lastEditedAt" [] Decode.string


locked : FieldDecoder String Api.Object.Issue
locked =
    Field.fieldDecoder "locked" [] Decode.string


milestone : Object milestone Api.Object.Milestone -> FieldDecoder milestone Api.Object.Issue
milestone object =
    Object.single "milestone" [] object


number : FieldDecoder String Api.Object.Issue
number =
    Field.fieldDecoder "number" [] Decode.string


participants : Object participants Api.Object.UserConnection -> FieldDecoder participants Api.Object.Issue
participants object =
    Object.single "participants" [] object


projectCards : Object projectCards Api.Object.ProjectCardConnection -> FieldDecoder projectCards Api.Object.Issue
projectCards object =
    Object.single "projectCards" [] object


publishedAt : FieldDecoder String Api.Object.Issue
publishedAt =
    Field.fieldDecoder "publishedAt" [] Decode.string


reactionGroups : FieldDecoder (List Object.ReactionGroup) Api.Object.Issue
reactionGroups =
    Field.fieldDecoder "reactionGroups" [] (Api.Object.ReactionGroup.decoder |> Decode.list)


reactions : Object reactions Api.Object.ReactionConnection -> FieldDecoder reactions Api.Object.Issue
reactions object =
    Object.single "reactions" [] object


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.Issue
repository object =
    Object.single "repository" [] object


resourcePath : FieldDecoder String Api.Object.Issue
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


state : FieldDecoder Api.Enum.IssueState.IssueState Api.Object.Issue
state =
    Field.fieldDecoder "state" [] Api.Enum.IssueState.decoder


timeline : Object timeline Api.Object.IssueTimelineConnection -> FieldDecoder timeline Api.Object.Issue
timeline object =
    Object.single "timeline" [] object


title : FieldDecoder String Api.Object.Issue
title =
    Field.fieldDecoder "title" [] Decode.string


updatedAt : FieldDecoder String Api.Object.Issue
updatedAt =
    Field.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.Issue
url =
    Field.fieldDecoder "url" [] Decode.string


viewerCanReact : FieldDecoder String Api.Object.Issue
viewerCanReact =
    Field.fieldDecoder "viewerCanReact" [] Decode.string


viewerCanSubscribe : FieldDecoder String Api.Object.Issue
viewerCanSubscribe =
    Field.fieldDecoder "viewerCanSubscribe" [] Decode.string


viewerCanUpdate : FieldDecoder String Api.Object.Issue
viewerCanUpdate =
    Field.fieldDecoder "viewerCanUpdate" [] Decode.string


viewerCannotUpdateReasons : FieldDecoder (List String) Api.Object.Issue
viewerCannotUpdateReasons =
    Field.fieldDecoder "viewerCannotUpdateReasons" [] (Decode.string |> Decode.list)


viewerDidAuthor : FieldDecoder String Api.Object.Issue
viewerDidAuthor =
    Field.fieldDecoder "viewerDidAuthor" [] Decode.string


viewerSubscription : FieldDecoder Api.Enum.SubscriptionState.SubscriptionState Api.Object.Issue
viewerSubscription =
    Field.fieldDecoder "viewerSubscription" [] Api.Enum.SubscriptionState.decoder
