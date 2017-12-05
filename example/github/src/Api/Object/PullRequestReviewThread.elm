module Api.Object.PullRequestReviewThread exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PullRequestReviewThread
build constructor =
    Object.object constructor


comments : Object comments Api.Object.PullRequestReviewCommentConnection -> FieldDecoder comments Api.Object.PullRequestReviewThread
comments object =
    Object.single "comments" [] object


id : FieldDecoder String Api.Object.PullRequestReviewThread
id =
    Field.fieldDecoder "id" [] Decode.string


pullRequest : Object pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.PullRequestReviewThread
pullRequest object =
    Object.single "pullRequest" [] object


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.PullRequestReviewThread
repository object =
    Object.single "repository" [] object
