module Api.Object.ReviewRequest exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.ReviewRequest
selection constructor =
    Object.object constructor


databaseId : FieldDecoder Int Api.Object.ReviewRequest
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


id : FieldDecoder String Api.Object.ReviewRequest
id =
    Object.fieldDecoder "id" [] Decode.string


pullRequest : SelectionSet pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.ReviewRequest
pullRequest object =
    Object.single "pullRequest" [] object


requestedReviewer : FieldDecoder String Api.Object.ReviewRequest
requestedReviewer =
    Object.fieldDecoder "requestedReviewer" [] Decode.string


reviewer : SelectionSet reviewer Api.Object.User -> FieldDecoder reviewer Api.Object.ReviewRequest
reviewer object =
    Object.single "reviewer" [] object
