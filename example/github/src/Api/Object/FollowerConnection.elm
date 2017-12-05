module Api.Object.FollowerConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.FollowerConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.UserEdge) Api.Object.FollowerConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.UserEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.User) Api.Object.FollowerConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.User.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.FollowerConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.FollowerConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
