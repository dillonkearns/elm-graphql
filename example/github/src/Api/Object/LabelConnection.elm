module Api.Object.LabelConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.LabelConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.LabelEdge) Api.Object.LabelConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.LabelEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.Label) Api.Object.LabelConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.Label.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.LabelConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.LabelConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
