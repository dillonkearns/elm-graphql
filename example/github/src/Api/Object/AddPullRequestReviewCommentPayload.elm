module Api.Object.AddPullRequestReviewCommentPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.AddPullRequestReviewCommentPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.AddPullRequestReviewCommentPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


comment : Object comment Api.Object.PullRequestReviewComment -> FieldDecoder comment Api.Object.AddPullRequestReviewCommentPayload
comment object =
    Object.single "comment" [] object


commentEdge : Object commentEdge Api.Object.PullRequestReviewCommentEdge -> FieldDecoder commentEdge Api.Object.AddPullRequestReviewCommentPayload
commentEdge object =
    Object.single "commentEdge" [] object
