module Api.Object.PullRequestReview exposing (..)

import Api.Enum.CommentAuthorAssociation
import Api.Enum.PullRequestReviewState
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PullRequestReview
build constructor =
    Object.object constructor


author : Object author Api.Object.Actor -> FieldDecoder author Api.Object.PullRequestReview
author object =
    Object.single "author" [] object


authorAssociation : FieldDecoder Api.Enum.CommentAuthorAssociation.CommentAuthorAssociation Api.Object.PullRequestReview
authorAssociation =
    Object.fieldDecoder "authorAssociation" [] Api.Enum.CommentAuthorAssociation.decoder


body : FieldDecoder String Api.Object.PullRequestReview
body =
    Object.fieldDecoder "body" [] Decode.string


bodyHTML : FieldDecoder String Api.Object.PullRequestReview
bodyHTML =
    Object.fieldDecoder "bodyHTML" [] Decode.string


bodyText : FieldDecoder String Api.Object.PullRequestReview
bodyText =
    Object.fieldDecoder "bodyText" [] Decode.string


comments : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object comments Api.Object.PullRequestReviewCommentConnection -> FieldDecoder comments Api.Object.PullRequestReview
comments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string ]
                |> List.filterMap identity
    in
    Object.single "comments" optionalArgs object


commit : Object commit Api.Object.Commit -> FieldDecoder commit Api.Object.PullRequestReview
commit object =
    Object.single "commit" [] object


createdAt : FieldDecoder String Api.Object.PullRequestReview
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


createdViaEmail : FieldDecoder Bool Api.Object.PullRequestReview
createdViaEmail =
    Object.fieldDecoder "createdViaEmail" [] Decode.bool


databaseId : FieldDecoder Int Api.Object.PullRequestReview
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


editor : Object editor Api.Object.Actor -> FieldDecoder editor Api.Object.PullRequestReview
editor object =
    Object.single "editor" [] object


id : FieldDecoder String Api.Object.PullRequestReview
id =
    Object.fieldDecoder "id" [] Decode.string


lastEditedAt : FieldDecoder String Api.Object.PullRequestReview
lastEditedAt =
    Object.fieldDecoder "lastEditedAt" [] Decode.string


publishedAt : FieldDecoder String Api.Object.PullRequestReview
publishedAt =
    Object.fieldDecoder "publishedAt" [] Decode.string


pullRequest : Object pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.PullRequestReview
pullRequest object =
    Object.single "pullRequest" [] object


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.PullRequestReview
repository object =
    Object.single "repository" [] object


resourcePath : FieldDecoder String Api.Object.PullRequestReview
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


state : FieldDecoder Api.Enum.PullRequestReviewState.PullRequestReviewState Api.Object.PullRequestReview
state =
    Object.fieldDecoder "state" [] Api.Enum.PullRequestReviewState.decoder


submittedAt : FieldDecoder String Api.Object.PullRequestReview
submittedAt =
    Object.fieldDecoder "submittedAt" [] Decode.string


updatedAt : FieldDecoder String Api.Object.PullRequestReview
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.PullRequestReview
url =
    Object.fieldDecoder "url" [] Decode.string


viewerCanDelete : FieldDecoder Bool Api.Object.PullRequestReview
viewerCanDelete =
    Object.fieldDecoder "viewerCanDelete" [] Decode.bool


viewerCanUpdate : FieldDecoder Bool Api.Object.PullRequestReview
viewerCanUpdate =
    Object.fieldDecoder "viewerCanUpdate" [] Decode.bool


viewerCannotUpdateReasons : FieldDecoder (List String) Api.Object.PullRequestReview
viewerCannotUpdateReasons =
    Object.fieldDecoder "viewerCannotUpdateReasons" [] (Decode.string |> Decode.list)


viewerDidAuthor : FieldDecoder Bool Api.Object.PullRequestReview
viewerDidAuthor =
    Object.fieldDecoder "viewerDidAuthor" [] Decode.bool
