module Api.Object.PullRequestCommitConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PullRequestCommitConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.PullRequestCommitEdge) Api.Object.PullRequestCommitConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.PullRequestCommitEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.PullRequestCommit) Api.Object.PullRequestCommitConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.PullRequestCommit.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.PullRequestCommitConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.PullRequestCommitConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
