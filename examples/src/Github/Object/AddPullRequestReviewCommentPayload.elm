module Github.Object.AddPullRequestReviewCommentPayload exposing (..)

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


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.AddPullRequestReviewCommentPayload
selection constructor =
    Object.object constructor


{-| A unique identifier for the client performing the mutation.
-}
clientMutationId : FieldDecoder (Maybe String) Github.Object.AddPullRequestReviewCommentPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] (Decode.string |> Decode.maybe)


{-| The newly created comment.
-}
comment : SelectionSet selection Github.Object.PullRequestReviewComment -> FieldDecoder selection Github.Object.AddPullRequestReviewCommentPayload
comment object =
    Object.selectionFieldDecoder "comment" [] object identity


{-| The edge from the review's comment connection.
-}
commentEdge : SelectionSet selection Github.Object.PullRequestReviewCommentEdge -> FieldDecoder selection Github.Object.AddPullRequestReviewCommentPayload
commentEdge object =
    Object.selectionFieldDecoder "commentEdge" [] object identity
