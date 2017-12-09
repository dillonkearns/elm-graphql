module Api.Object.DeletePullRequestReviewPayload exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.DeletePullRequestReviewPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.DeletePullRequestReviewPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


pullRequestReview : Object pullRequestReview Api.Object.PullRequestReview -> FieldDecoder pullRequestReview Api.Object.DeletePullRequestReviewPayload
pullRequestReview object =
    Object.single "pullRequestReview" [] object
