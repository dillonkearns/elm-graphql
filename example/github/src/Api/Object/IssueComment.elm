module Api.Object.IssueComment exposing (..)

import Api.Enum.CommentAuthorAssociation
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.IssueComment
build constructor =
    Object.object constructor


author : Object author Api.Object.Actor -> FieldDecoder author Api.Object.IssueComment
author object =
    Object.single "author" [] object


authorAssociation : FieldDecoder Api.Enum.CommentAuthorAssociation.CommentAuthorAssociation Api.Object.IssueComment
authorAssociation =
    Field.fieldDecoder "authorAssociation" [] Api.Enum.CommentAuthorAssociation.decoder


body : FieldDecoder String Api.Object.IssueComment
body =
    Field.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Api.Object.IssueComment
bodyHTML =
    Field.fieldDecoder "bodyHTML" [] Decode.string


bodyText : FieldDecoder String Api.Object.IssueComment
bodyText =
    Field.fieldDecoder "bodyText" [] Decode.string


createdAt : FieldDecoder String Api.Object.IssueComment
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


createdViaEmail : FieldDecoder Bool Api.Object.IssueComment
createdViaEmail =
    Field.fieldDecoder "createdViaEmail" [] Decode.bool


databaseId : FieldDecoder Int Api.Object.IssueComment
databaseId =
    Field.fieldDecoder "databaseId" [] Decode.int


editor : Object editor Api.Object.Actor -> FieldDecoder editor Api.Object.IssueComment
editor object =
    Object.single "editor" [] object


id : FieldDecoder String Api.Object.IssueComment
id =
    Field.fieldDecoder "id" [] Decode.string


issue : Object issue Api.Object.Issue -> FieldDecoder issue Api.Object.IssueComment
issue object =
    Object.single "issue" [] object


lastEditedAt : FieldDecoder String Api.Object.IssueComment
lastEditedAt =
    Field.fieldDecoder "lastEditedAt" [] Decode.string


publishedAt : FieldDecoder String Api.Object.IssueComment
publishedAt =
    Field.fieldDecoder "publishedAt" [] Decode.string


pullRequest : Object pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.IssueComment
pullRequest object =
    Object.single "pullRequest" [] object


reactionGroups : Object reactionGroups Api.Object.ReactionGroup -> FieldDecoder (List reactionGroups) Api.Object.IssueComment
reactionGroups object =
    Object.listOf "reactionGroups" [] object


reactions : Object reactions Api.Object.ReactionConnection -> FieldDecoder reactions Api.Object.IssueComment
reactions object =
    Object.single "reactions" [] object


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.IssueComment
repository object =
    Object.single "repository" [] object


resourcePath : FieldDecoder String Api.Object.IssueComment
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


updatedAt : FieldDecoder String Api.Object.IssueComment
updatedAt =
    Field.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.IssueComment
url =
    Field.fieldDecoder "url" [] Decode.string


viewerCanDelete : FieldDecoder Bool Api.Object.IssueComment
viewerCanDelete =
    Field.fieldDecoder "viewerCanDelete" [] Decode.bool


viewerCanReact : FieldDecoder Bool Api.Object.IssueComment
viewerCanReact =
    Field.fieldDecoder "viewerCanReact" [] Decode.bool


viewerCanUpdate : FieldDecoder Bool Api.Object.IssueComment
viewerCanUpdate =
    Field.fieldDecoder "viewerCanUpdate" [] Decode.bool


viewerCannotUpdateReasons : FieldDecoder (List String) Api.Object.IssueComment
viewerCannotUpdateReasons =
    Field.fieldDecoder "viewerCannotUpdateReasons" [] (Decode.string |> Decode.list)


viewerDidAuthor : FieldDecoder Bool Api.Object.IssueComment
viewerDidAuthor =
    Field.fieldDecoder "viewerDidAuthor" [] Decode.bool
