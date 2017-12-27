module Github.Object.AddPullRequestReviewPayload exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.AddPullRequestReviewPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Github.Object.AddPullRequestReviewPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


pullRequestReview : SelectionSet pullRequestReview Github.Object.PullRequestReview -> FieldDecoder pullRequestReview Github.Object.AddPullRequestReviewPayload
pullRequestReview object =
    Object.single "pullRequestReview" [] object


reviewEdge : SelectionSet reviewEdge Github.Object.PullRequestReviewEdge -> FieldDecoder reviewEdge Github.Object.AddPullRequestReviewPayload
reviewEdge object =
    Object.single "reviewEdge" [] object
