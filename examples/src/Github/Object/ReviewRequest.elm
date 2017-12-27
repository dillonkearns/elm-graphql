module Github.Object.ReviewRequest exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ReviewRequest
selection constructor =
    Object.object constructor


databaseId : FieldDecoder Int Github.Object.ReviewRequest
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


id : FieldDecoder String Github.Object.ReviewRequest
id =
    Object.fieldDecoder "id" [] Decode.string


pullRequest : SelectionSet pullRequest Github.Object.PullRequest -> FieldDecoder pullRequest Github.Object.ReviewRequest
pullRequest object =
    Object.single "pullRequest" [] object


requestedReviewer : FieldDecoder String Github.Object.ReviewRequest
requestedReviewer =
    Object.fieldDecoder "requestedReviewer" [] Decode.string


reviewer : SelectionSet reviewer Github.Object.User -> FieldDecoder reviewer Github.Object.ReviewRequest
reviewer object =
    Object.single "reviewer" [] object
