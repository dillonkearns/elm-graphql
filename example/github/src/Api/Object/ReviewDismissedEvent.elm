module Api.Object.ReviewDismissedEvent exposing (..)

import Api.Enum.PullRequestReviewState
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.ReviewDismissedEvent
selection constructor =
    Object.object constructor


actor : SelectionSet actor Api.Object.Actor -> FieldDecoder actor Api.Object.ReviewDismissedEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Api.Object.ReviewDismissedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder Int Api.Object.ReviewDismissedEvent
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


id : FieldDecoder String Api.Object.ReviewDismissedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


message : FieldDecoder String Api.Object.ReviewDismissedEvent
message =
    Object.fieldDecoder "message" [] Decode.string


messageHtml : FieldDecoder String Api.Object.ReviewDismissedEvent
messageHtml =
    Object.fieldDecoder "messageHtml" [] Decode.string


previousReviewState : FieldDecoder Api.Enum.PullRequestReviewState.PullRequestReviewState Api.Object.ReviewDismissedEvent
previousReviewState =
    Object.fieldDecoder "previousReviewState" [] Api.Enum.PullRequestReviewState.decoder


pullRequest : SelectionSet pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.ReviewDismissedEvent
pullRequest object =
    Object.single "pullRequest" [] object


pullRequestCommit : SelectionSet pullRequestCommit Api.Object.PullRequestCommit -> FieldDecoder pullRequestCommit Api.Object.ReviewDismissedEvent
pullRequestCommit object =
    Object.single "pullRequestCommit" [] object


resourcePath : FieldDecoder String Api.Object.ReviewDismissedEvent
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


review : SelectionSet review Api.Object.PullRequestReview -> FieldDecoder review Api.Object.ReviewDismissedEvent
review object =
    Object.single "review" [] object


url : FieldDecoder String Api.Object.ReviewDismissedEvent
url =
    Object.fieldDecoder "url" [] Decode.string
