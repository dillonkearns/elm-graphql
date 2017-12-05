module Api.Object.ReviewDismissedEvent exposing (..)

import Api.Enum.PullRequestReviewState
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReviewDismissedEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.ReviewDismissedEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Api.Object.ReviewDismissedEvent
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder String Api.Object.ReviewDismissedEvent
databaseId =
    Field.fieldDecoder "databaseId" [] Decode.string


id : FieldDecoder String Api.Object.ReviewDismissedEvent
id =
    Field.fieldDecoder "id" [] Decode.string


message : FieldDecoder String Api.Object.ReviewDismissedEvent
message =
    Field.fieldDecoder "message" [] Decode.string


messageHtml : FieldDecoder String Api.Object.ReviewDismissedEvent
messageHtml =
    Field.fieldDecoder "messageHtml" [] Decode.string


previousReviewState : FieldDecoder Api.Enum.PullRequestReviewState.PullRequestReviewState Api.Object.ReviewDismissedEvent
previousReviewState =
    Field.fieldDecoder "previousReviewState" [] Api.Enum.PullRequestReviewState.decoder


pullRequest : Object pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.ReviewDismissedEvent
pullRequest object =
    Object.single "pullRequest" [] object


pullRequestCommit : Object pullRequestCommit Api.Object.PullRequestCommit -> FieldDecoder pullRequestCommit Api.Object.ReviewDismissedEvent
pullRequestCommit object =
    Object.single "pullRequestCommit" [] object


resourcePath : FieldDecoder String Api.Object.ReviewDismissedEvent
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


review : Object review Api.Object.PullRequestReview -> FieldDecoder review Api.Object.ReviewDismissedEvent
review object =
    Object.single "review" [] object


url : FieldDecoder String Api.Object.ReviewDismissedEvent
url =
    Field.fieldDecoder "url" [] Decode.string
