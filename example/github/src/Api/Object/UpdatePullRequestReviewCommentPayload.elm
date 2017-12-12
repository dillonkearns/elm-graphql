module Api.Object.UpdatePullRequestReviewCommentPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.UpdatePullRequestReviewCommentPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.UpdatePullRequestReviewCommentPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


pullRequestReviewComment : Object pullRequestReviewComment Api.Object.PullRequestReviewComment -> FieldDecoder pullRequestReviewComment Api.Object.UpdatePullRequestReviewCommentPayload
pullRequestReviewComment object =
    Object.single "pullRequestReviewComment" [] object
