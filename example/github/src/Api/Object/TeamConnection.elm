module Api.Object.TeamConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.TeamConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.TeamEdge) Api.Object.TeamConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.TeamEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.Team) Api.Object.TeamConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.Team.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.TeamConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.TeamConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
