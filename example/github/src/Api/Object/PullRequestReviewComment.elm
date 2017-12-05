module Api.Object.PullRequestReviewComment exposing (..)

import Api.Enum.CommentAuthorAssociation
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PullRequestReviewComment
build constructor =
    Object.object constructor


author : Object author Api.Object.Actor -> FieldDecoder author Api.Object.PullRequestReviewComment
author object =
    Object.single "author" [] object


authorAssociation : FieldDecoder Api.Enum.CommentAuthorAssociation.CommentAuthorAssociation Api.Object.PullRequestReviewComment
authorAssociation =
    Field.fieldDecoder "authorAssociation" [] Api.Enum.CommentAuthorAssociation.decoder


body : FieldDecoder String Api.Object.PullRequestReviewComment
body =
    Field.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Api.Object.PullRequestReviewComment
bodyHTML =
    Field.fieldDecoder "bodyHTML" [] Decode.string


bodyText : FieldDecoder String Api.Object.PullRequestReviewComment
bodyText =
    Field.fieldDecoder "bodyText" [] Decode.string


commit : Object commit Api.Object.Commit -> FieldDecoder commit Api.Object.PullRequestReviewComment
commit object =
    Object.single "commit" [] object


createdAt : FieldDecoder String Api.Object.PullRequestReviewComment
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


createdViaEmail : FieldDecoder String Api.Object.PullRequestReviewComment
createdViaEmail =
    Field.fieldDecoder "createdViaEmail" [] Decode.string


databaseId : FieldDecoder String Api.Object.PullRequestReviewComment
databaseId =
    Field.fieldDecoder "databaseId" [] Decode.string


diffHunk : FieldDecoder String Api.Object.PullRequestReviewComment
diffHunk =
    Field.fieldDecoder "diffHunk" [] Decode.string


draftedAt : FieldDecoder String Api.Object.PullRequestReviewComment
draftedAt =
    Field.fieldDecoder "draftedAt" [] Decode.string


editor : Object editor Api.Object.Actor -> FieldDecoder editor Api.Object.PullRequestReviewComment
editor object =
    Object.single "editor" [] object


id : FieldDecoder String Api.Object.PullRequestReviewComment
id =
    Field.fieldDecoder "id" [] Decode.string


lastEditedAt : FieldDecoder String Api.Object.PullRequestReviewComment
lastEditedAt =
    Field.fieldDecoder "lastEditedAt" [] Decode.string


originalCommit : Object originalCommit Api.Object.Commit -> FieldDecoder originalCommit Api.Object.PullRequestReviewComment
originalCommit object =
    Object.single "originalCommit" [] object


originalPosition : FieldDecoder String Api.Object.PullRequestReviewComment
originalPosition =
    Field.fieldDecoder "originalPosition" [] Decode.string


path : FieldDecoder String Api.Object.PullRequestReviewComment
path =
    Field.fieldDecoder "path" [] Decode.string


position : FieldDecoder String Api.Object.PullRequestReviewComment
position =
    Field.fieldDecoder "position" [] Decode.string


publishedAt : FieldDecoder String Api.Object.PullRequestReviewComment
publishedAt =
    Field.fieldDecoder "publishedAt" [] Decode.string


pullRequest : Object pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.PullRequestReviewComment
pullRequest object =
    Object.single "pullRequest" [] object


pullRequestReview : Object pullRequestReview Api.Object.PullRequestReview -> FieldDecoder pullRequestReview Api.Object.PullRequestReviewComment
pullRequestReview object =
    Object.single "pullRequestReview" [] object


reactionGroups : FieldDecoder (List Object.ReactionGroup) Api.Object.PullRequestReviewComment
reactionGroups =
    Field.fieldDecoder "reactionGroups" [] (Api.Object.ReactionGroup.decoder |> Decode.list)


reactions : Object reactions Api.Object.ReactionConnection -> FieldDecoder reactions Api.Object.PullRequestReviewComment
reactions object =
    Object.single "reactions" [] object


replyTo : Object replyTo Api.Object.PullRequestReviewComment -> FieldDecoder replyTo Api.Object.PullRequestReviewComment
replyTo object =
    Object.single "replyTo" [] object


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.PullRequestReviewComment
repository object =
    Object.single "repository" [] object


resourcePath : FieldDecoder String Api.Object.PullRequestReviewComment
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


updatedAt : FieldDecoder String Api.Object.PullRequestReviewComment
updatedAt =
    Field.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.PullRequestReviewComment
url =
    Field.fieldDecoder "url" [] Decode.string


viewerCanDelete : FieldDecoder String Api.Object.PullRequestReviewComment
viewerCanDelete =
    Field.fieldDecoder "viewerCanDelete" [] Decode.string


viewerCanReact : FieldDecoder String Api.Object.PullRequestReviewComment
viewerCanReact =
    Field.fieldDecoder "viewerCanReact" [] Decode.string


viewerCanUpdate : FieldDecoder String Api.Object.PullRequestReviewComment
viewerCanUpdate =
    Field.fieldDecoder "viewerCanUpdate" [] Decode.string


viewerCannotUpdateReasons : FieldDecoder (List String) Api.Object.PullRequestReviewComment
viewerCannotUpdateReasons =
    Field.fieldDecoder "viewerCannotUpdateReasons" [] (Decode.string |> Decode.list)


viewerDidAuthor : FieldDecoder String Api.Object.PullRequestReviewComment
viewerDidAuthor =
    Field.fieldDecoder "viewerDidAuthor" [] Decode.string
