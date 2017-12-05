module Api.Object.PullRequestConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PullRequestConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.PullRequestEdge) Api.Object.PullRequestConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.PullRequestEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.PullRequest) Api.Object.PullRequestConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.PullRequest.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.PullRequestConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.PullRequestConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
