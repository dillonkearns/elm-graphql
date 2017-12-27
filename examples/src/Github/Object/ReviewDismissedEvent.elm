module Github.Object.ReviewDismissedEvent exposing (..)

import Github.Enum.PullRequestReviewState
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ReviewDismissedEvent
selection constructor =
    Object.object constructor


actor : SelectionSet actor Github.Object.Actor -> FieldDecoder actor Github.Object.ReviewDismissedEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Github.Object.ReviewDismissedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder Int Github.Object.ReviewDismissedEvent
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


id : FieldDecoder String Github.Object.ReviewDismissedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


message : FieldDecoder String Github.Object.ReviewDismissedEvent
message =
    Object.fieldDecoder "message" [] Decode.string


messageHtml : FieldDecoder String Github.Object.ReviewDismissedEvent
messageHtml =
    Object.fieldDecoder "messageHtml" [] Decode.string


previousReviewState : FieldDecoder Github.Enum.PullRequestReviewState.PullRequestReviewState Github.Object.ReviewDismissedEvent
previousReviewState =
    Object.fieldDecoder "previousReviewState" [] Github.Enum.PullRequestReviewState.decoder


pullRequest : SelectionSet pullRequest Github.Object.PullRequest -> FieldDecoder pullRequest Github.Object.ReviewDismissedEvent
pullRequest object =
    Object.single "pullRequest" [] object


pullRequestCommit : SelectionSet pullRequestCommit Github.Object.PullRequestCommit -> FieldDecoder pullRequestCommit Github.Object.ReviewDismissedEvent
pullRequestCommit object =
    Object.single "pullRequestCommit" [] object


resourcePath : FieldDecoder String Github.Object.ReviewDismissedEvent
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


review : SelectionSet review Github.Object.PullRequestReview -> FieldDecoder review Github.Object.ReviewDismissedEvent
review object =
    Object.single "review" [] object


url : FieldDecoder String Github.Object.ReviewDismissedEvent
url =
    Object.fieldDecoder "url" [] Decode.string
