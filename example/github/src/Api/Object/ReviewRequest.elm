module Api.Object.ReviewRequest exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReviewRequest
build constructor =
    Object.object constructor


databaseId : FieldDecoder Int Api.Object.ReviewRequest
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


id : FieldDecoder String Api.Object.ReviewRequest
id =
    Object.fieldDecoder "id" [] Decode.string


pullRequest : Object pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.ReviewRequest
pullRequest object =
    Object.single "pullRequest" [] object


requestedReviewer : FieldDecoder String Api.Object.ReviewRequest
requestedReviewer =
    Object.fieldDecoder "requestedReviewer" [] Decode.string


reviewer : Object reviewer Api.Object.User -> FieldDecoder reviewer Api.Object.ReviewRequest
reviewer object =
    Object.single "reviewer" [] object
