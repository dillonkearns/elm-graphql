module Api.Object.TeamMemberConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.TeamMemberConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.TeamMemberEdge) Api.Object.TeamMemberConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.TeamMemberEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.User) Api.Object.TeamMemberConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.User.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.TeamMemberConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.TeamMemberConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
