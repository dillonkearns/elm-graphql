module Api.Object.RepositoryTopicConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RepositoryTopicConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.RepositoryTopicEdge) Api.Object.RepositoryTopicConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.RepositoryTopicEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.RepositoryTopic) Api.Object.RepositoryTopicConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.RepositoryTopic.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.RepositoryTopicConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.RepositoryTopicConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
