module Api.Object.UserConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.UserConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.UserEdge) Api.Object.UserConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.UserEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.User) Api.Object.UserConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.User.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.UserConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.UserConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
