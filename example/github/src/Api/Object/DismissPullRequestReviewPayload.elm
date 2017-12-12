module Api.Object.DismissPullRequestReviewPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.DismissPullRequestReviewPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.DismissPullRequestReviewPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


pullRequestReview : Object pullRequestReview Api.Object.PullRequestReview -> FieldDecoder pullRequestReview Api.Object.DismissPullRequestReviewPayload
pullRequestReview object =
    Object.single "pullRequestReview" [] object
