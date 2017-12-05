module Api.Object.ReviewRequest exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReviewRequest
build constructor =
    Object.object constructor


databaseId : FieldDecoder String Api.Object.ReviewRequest
databaseId =
    Field.fieldDecoder "databaseId" [] Decode.string


id : FieldDecoder String Api.Object.ReviewRequest
id =
    Field.fieldDecoder "id" [] Decode.string


pullRequest : Object pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.ReviewRequest
pullRequest object =
    Object.single "pullRequest" [] object


requestedReviewer : FieldDecoder String Api.Object.ReviewRequest
requestedReviewer =
    Field.fieldDecoder "requestedReviewer" [] Decode.string


reviewer : Object reviewer Api.Object.User -> FieldDecoder reviewer Api.Object.ReviewRequest
reviewer object =
    Object.single "reviewer" [] object
