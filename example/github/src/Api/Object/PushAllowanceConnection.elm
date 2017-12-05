module Api.Object.PushAllowanceConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PushAllowanceConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.PushAllowanceEdge) Api.Object.PushAllowanceConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.PushAllowanceEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.PushAllowance) Api.Object.PushAllowanceConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.PushAllowance.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.PushAllowanceConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.PushAllowanceConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
