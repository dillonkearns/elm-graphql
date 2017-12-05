module Api.Object.FollowingConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.FollowingConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.UserEdge) Api.Object.FollowingConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.UserEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.User) Api.Object.FollowingConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.User.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.FollowingConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.FollowingConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
