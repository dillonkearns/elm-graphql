module Github.Object.UpdatePullRequestReviewCommentPayload exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.UpdatePullRequestReviewCommentPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Github.Object.UpdatePullRequestReviewCommentPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


pullRequestReviewComment : SelectionSet pullRequestReviewComment Github.Object.PullRequestReviewComment -> FieldDecoder pullRequestReviewComment Github.Object.UpdatePullRequestReviewCommentPayload
pullRequestReviewComment object =
    Object.selectionFieldDecoder "pullRequestReviewComment" [] object identity
