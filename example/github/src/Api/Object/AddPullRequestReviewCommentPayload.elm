module Api.Object.AddPullRequestReviewCommentPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.AddPullRequestReviewCommentPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.AddPullRequestReviewCommentPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


comment : SelectionSet comment Api.Object.PullRequestReviewComment -> FieldDecoder comment Api.Object.AddPullRequestReviewCommentPayload
comment object =
    Object.single "comment" [] object


commentEdge : SelectionSet commentEdge Api.Object.PullRequestReviewCommentEdge -> FieldDecoder commentEdge Api.Object.AddPullRequestReviewCommentPayload
commentEdge object =
    Object.single "commentEdge" [] object
