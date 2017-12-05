module Api.Object.TopicConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.TopicConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.TopicEdge) Api.Object.TopicConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.TopicEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.Topic) Api.Object.TopicConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.Topic.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.TopicConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.TopicConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
