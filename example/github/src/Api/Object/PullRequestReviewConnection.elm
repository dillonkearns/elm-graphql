module Api.Object.PullRequestReviewConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PullRequestReviewConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.PullRequestReviewEdge) Api.Object.PullRequestReviewConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.PullRequestReviewEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.PullRequestReview) Api.Object.PullRequestReviewConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.PullRequestReview.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.PullRequestReviewConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.PullRequestReviewConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
