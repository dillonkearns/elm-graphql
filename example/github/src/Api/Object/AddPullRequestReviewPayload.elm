module Api.Object.AddPullRequestReviewPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.AddPullRequestReviewPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.AddPullRequestReviewPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


pullRequestReview : Object pullRequestReview Api.Object.PullRequestReview -> FieldDecoder pullRequestReview Api.Object.AddPullRequestReviewPayload
pullRequestReview object =
    Object.single "pullRequestReview" [] object


reviewEdge : Object reviewEdge Api.Object.PullRequestReviewEdge -> FieldDecoder reviewEdge Api.Object.AddPullRequestReviewPayload
reviewEdge object =
    Object.single "reviewEdge" [] object
