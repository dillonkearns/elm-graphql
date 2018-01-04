module Github.Object.RequestReviewsPayload exposing (..)

import Github.Interface
import Github.Object
import Github.Union
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.RequestReviewsPayload
selection constructor =
    Object.object constructor


{-| A unique identifier for the client performing the mutation.
-}
clientMutationId : FieldDecoder (Maybe String) Github.Object.RequestReviewsPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] (Decode.string |> Decode.maybe)


{-| The pull request that is getting requests.
-}
pullRequest : SelectionSet selection Github.Object.PullRequest -> FieldDecoder selection Github.Object.RequestReviewsPayload
pullRequest object =
    Object.selectionFieldDecoder "pullRequest" [] object identity


{-| The edge from the pull request to the requested reviewers.
-}
requestedReviewersEdge : SelectionSet selection Github.Object.UserEdge -> FieldDecoder selection Github.Object.RequestReviewsPayload
requestedReviewersEdge object =
    Object.selectionFieldDecoder "requestedReviewersEdge" [] object identity
