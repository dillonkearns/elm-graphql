module Api.Object.PullRequestReviewEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PullRequestReviewEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.PullRequestReviewEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.PullRequestReview -> FieldDecoder node Api.Object.PullRequestReviewEdge
node object =
    Object.single "node" [] object
