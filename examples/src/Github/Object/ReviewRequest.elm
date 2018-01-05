module Github.Object.ReviewRequest exposing (..)

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


{-| Select fields to build up a SelectionSet for this object.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ReviewRequest
selection constructor =
    Object.object constructor


{-| Identifies the primary key from the database.
-}
databaseId : FieldDecoder (Maybe Int) Github.Object.ReviewRequest
databaseId =
    Object.fieldDecoder "databaseId" [] (Decode.int |> Decode.maybe)


id : FieldDecoder String Github.Object.ReviewRequest
id =
    Object.fieldDecoder "id" [] Decode.string


{-| Identifies the pull request associated with this review request.
-}
pullRequest : SelectionSet selection Github.Object.PullRequest -> FieldDecoder selection Github.Object.ReviewRequest
pullRequest object =
    Object.selectionFieldDecoder "pullRequest" [] object identity


{-| The reviewer that is requested.
-}
requestedReviewer : SelectionSet selection Github.Union.RequestedReviewer -> FieldDecoder (Maybe selection) Github.Object.ReviewRequest
requestedReviewer object =
    Object.selectionFieldDecoder "requestedReviewer" [] object (identity >> Decode.maybe)


{-| Identifies the author associated with this review request.
-}
reviewer : SelectionSet selection Github.Object.User -> FieldDecoder (Maybe selection) Github.Object.ReviewRequest
reviewer object =
    Object.selectionFieldDecoder "reviewer" [] object (identity >> Decode.maybe)
