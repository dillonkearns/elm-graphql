module Api.Object.PullRequestReview exposing (..)

import Api.Enum.CommentAuthorAssociation
import Api.Enum.PullRequestReviewState
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PullRequestReview
build constructor =
    Object.object constructor


author : Object author Api.Object.Actor -> FieldDecoder author Api.Object.PullRequestReview
author object =
    Object.single "author" [] object


authorAssociation : FieldDecoder Api.Enum.CommentAuthorAssociation.CommentAuthorAssociation Api.Object.PullRequestReview
authorAssociation =
    Field.fieldDecoder "authorAssociation" [] Api.Enum.CommentAuthorAssociation.decoder


body : FieldDecoder String Api.Object.PullRequestReview
body =
    Field.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Api.Object.PullRequestReview
bodyHTML =
    Field.fieldDecoder "bodyHTML" [] Decode.string


bodyText : FieldDecoder String Api.Object.PullRequestReview
bodyText =
    Field.fieldDecoder "bodyText" [] Decode.string


comments : Object comments Api.Object.PullRequestReviewCommentConnection -> FieldDecoder comments Api.Object.PullRequestReview
comments object =
    Object.single "comments" [] object


commit : Object commit Api.Object.Commit -> FieldDecoder commit Api.Object.PullRequestReview
commit object =
    Object.single "commit" [] object


createdAt : FieldDecoder String Api.Object.PullRequestReview
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


createdViaEmail : FieldDecoder Bool Api.Object.PullRequestReview
createdViaEmail =
    Field.fieldDecoder "createdViaEmail" [] Decode.bool


databaseId : FieldDecoder Int Api.Object.PullRequestReview
databaseId =
    Field.fieldDecoder "databaseId" [] Decode.int


editor : Object editor Api.Object.Actor -> FieldDecoder editor Api.Object.PullRequestReview
editor object =
    Object.single "editor" [] object


id : FieldDecoder String Api.Object.PullRequestReview
id =
    Field.fieldDecoder "id" [] Decode.string


lastEditedAt : FieldDecoder String Api.Object.PullRequestReview
lastEditedAt =
    Field.fieldDecoder "lastEditedAt" [] Decode.string


publishedAt : FieldDecoder String Api.Object.PullRequestReview
publishedAt =
    Field.fieldDecoder "publishedAt" [] Decode.string


pullRequest : Object pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.PullRequestReview
pullRequest object =
    Object.single "pullRequest" [] object


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.PullRequestReview
repository object =
    Object.single "repository" [] object


resourcePath : FieldDecoder String Api.Object.PullRequestReview
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


state : FieldDecoder Api.Enum.PullRequestReviewState.PullRequestReviewState Api.Object.PullRequestReview
state =
    Field.fieldDecoder "state" [] Api.Enum.PullRequestReviewState.decoder


submittedAt : FieldDecoder String Api.Object.PullRequestReview
submittedAt =
    Field.fieldDecoder "submittedAt" [] Decode.string


updatedAt : FieldDecoder String Api.Object.PullRequestReview
updatedAt =
    Field.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.PullRequestReview
url =
    Field.fieldDecoder "url" [] Decode.string


viewerCanDelete : FieldDecoder Bool Api.Object.PullRequestReview
viewerCanDelete =
    Field.fieldDecoder "viewerCanDelete" [] Decode.bool


viewerCanUpdate : FieldDecoder Bool Api.Object.PullRequestReview
viewerCanUpdate =
    Field.fieldDecoder "viewerCanUpdate" [] Decode.bool


viewerCannotUpdateReasons : FieldDecoder (List String) Api.Object.PullRequestReview
viewerCannotUpdateReasons =
    Field.fieldDecoder "viewerCannotUpdateReasons" [] (Decode.string |> Decode.list)


viewerDidAuthor : FieldDecoder Bool Api.Object.PullRequestReview
viewerDidAuthor =
    Field.fieldDecoder "viewerDidAuthor" [] Decode.bool
