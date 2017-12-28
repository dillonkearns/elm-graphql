module Github.Object.DeletePullRequestReviewPayload exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.DeletePullRequestReviewPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Github.Object.DeletePullRequestReviewPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


pullRequestReview : SelectionSet pullRequestReview Github.Object.PullRequestReview -> FieldDecoder pullRequestReview Github.Object.DeletePullRequestReviewPayload
pullRequestReview object =
    Object.selectionFieldDecoder "pullRequestReview" [] object identity
