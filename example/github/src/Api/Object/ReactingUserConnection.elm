module Api.Object.ReactingUserConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReactingUserConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.ReactingUserEdge) Api.Object.ReactingUserConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.ReactingUserEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.User) Api.Object.ReactingUserConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.User.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.ReactingUserConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.ReactingUserConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
