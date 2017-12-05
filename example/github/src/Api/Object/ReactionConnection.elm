module Api.Object.ReactionConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReactionConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.ReactionEdge -> FieldDecoder (List edges) Api.Object.ReactionConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.Reaction -> FieldDecoder (List nodes) Api.Object.ReactionConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.ReactionConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.ReactionConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.int


viewerHasReacted : FieldDecoder Bool Api.Object.ReactionConnection
viewerHasReacted =
    Field.fieldDecoder "viewerHasReacted" [] Decode.bool
