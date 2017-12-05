module Api.Object.PublicKeyConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PublicKeyConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.PublicKeyEdge) Api.Object.PublicKeyConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.PublicKeyEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.PublicKey) Api.Object.PublicKeyConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.PublicKey.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.PublicKeyConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.PublicKeyConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
