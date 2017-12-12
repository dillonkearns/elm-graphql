module Api.Object.UpdatePullRequestReviewPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.UpdatePullRequestReviewPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.UpdatePullRequestReviewPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


pullRequestReview : Object pullRequestReview Api.Object.PullRequestReview -> FieldDecoder pullRequestReview Api.Object.UpdatePullRequestReviewPayload
pullRequestReview object =
    Object.single "pullRequestReview" [] object
