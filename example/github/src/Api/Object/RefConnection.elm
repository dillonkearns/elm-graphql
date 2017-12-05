module Api.Object.RefConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RefConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.RefEdge) Api.Object.RefConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.RefEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.Ref) Api.Object.RefConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.Ref.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.RefConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.RefConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
