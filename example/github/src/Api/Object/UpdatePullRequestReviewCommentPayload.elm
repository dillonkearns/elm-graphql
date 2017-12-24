module Api.Object.UpdatePullRequestReviewCommentPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.UpdatePullRequestReviewCommentPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.UpdatePullRequestReviewCommentPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


pullRequestReviewComment : SelectionSet pullRequestReviewComment Api.Object.PullRequestReviewComment -> FieldDecoder pullRequestReviewComment Api.Object.UpdatePullRequestReviewCommentPayload
pullRequestReviewComment object =
    Object.single "pullRequestReviewComment" [] object
