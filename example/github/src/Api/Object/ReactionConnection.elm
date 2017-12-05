module Api.Object.ReactionConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReactionConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.ReactionEdge) Api.Object.ReactionConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.ReactionEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.Reaction) Api.Object.ReactionConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.Reaction.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.ReactionConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.ReactionConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string


viewerHasReacted : FieldDecoder String Api.Object.ReactionConnection
viewerHasReacted =
    Field.fieldDecoder "viewerHasReacted" [] Decode.string
