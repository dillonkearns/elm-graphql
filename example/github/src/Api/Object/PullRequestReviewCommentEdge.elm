module Api.Object.PullRequestReviewCommentEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PullRequestReviewCommentEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.PullRequestReviewCommentEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.PullRequestReviewComment -> FieldDecoder node Api.Object.PullRequestReviewCommentEdge
node object =
    Object.single "node" [] object
