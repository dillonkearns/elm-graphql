-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql
module GithubNoFormat.Object.RequestReviewsPayload exposing (..)

import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.SelectionSet exposing (SelectionSet)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import GithubNoFormat.Object
import GithubNoFormat.Interface
import GithubNoFormat.Union
import GithubNoFormat.Scalar
import GithubNoFormat.InputObject
import GithubNoFormat.ScalarCodecs
import Json.Decode as Decode
import Graphql.Internal.Encode as Encode exposing (Value)

{-| A unique identifier for the client performing the mutation.
-}
clientMutationId : SelectionSet (Maybe String) GithubNoFormat.Object.RequestReviewsPayload
clientMutationId =
      Object.selectionForField "(Maybe String)" "clientMutationId" [] (Decode.string |> Decode.nullable)


{-| The pull request that is getting requests.
-}
pullRequest : SelectionSet decodesTo GithubNoFormat.Object.PullRequest
 -> SelectionSet decodesTo GithubNoFormat.Object.RequestReviewsPayload
pullRequest object____ =
      Object.selectionForCompositeField "pullRequest" [] (object____) (Basics.identity)


{-| The edge from the pull request to the requested reviewers.
-}
requestedReviewersEdge : SelectionSet decodesTo GithubNoFormat.Object.UserEdge
 -> SelectionSet decodesTo GithubNoFormat.Object.RequestReviewsPayload
requestedReviewersEdge object____ =
      Object.selectionForCompositeField "requestedReviewersEdge" [] (object____) (Basics.identity)
