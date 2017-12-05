module Api.Object.GistCommentConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.GistCommentConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.GistCommentEdge) Api.Object.GistCommentConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.GistCommentEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.GistComment) Api.Object.GistCommentConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.GistComment.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.GistCommentConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.GistCommentConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
