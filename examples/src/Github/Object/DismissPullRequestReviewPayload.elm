module Github.Object.DismissPullRequestReviewPayload exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.DismissPullRequestReviewPayload
selection constructor =
    Object.object constructor


{-| A unique identifier for the client performing the mutation.
-}
clientMutationId : FieldDecoder (Maybe String) Github.Object.DismissPullRequestReviewPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] (Decode.string |> Decode.maybe)


{-| The dismissed pull request review.
-}
pullRequestReview : SelectionSet pullRequestReview Github.Object.PullRequestReview -> FieldDecoder pullRequestReview Github.Object.DismissPullRequestReviewPayload
pullRequestReview object =
    Object.selectionFieldDecoder "pullRequestReview" [] object identity
