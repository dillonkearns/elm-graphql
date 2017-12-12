module Api.Object.RequestReviewsPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RequestReviewsPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.RequestReviewsPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


pullRequest : Object pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.RequestReviewsPayload
pullRequest object =
    Object.single "pullRequest" [] object


requestedReviewersEdge : Object requestedReviewersEdge Api.Object.UserEdge -> FieldDecoder requestedReviewersEdge Api.Object.RequestReviewsPayload
requestedReviewersEdge object =
    Object.single "requestedReviewersEdge" [] object
