module Api.Object.StargazerConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.StargazerConnection
build constructor =
    Object.object constructor



-- edges : FieldDecoder (List Api.Object.StargazerEdge) Api.Object.StargazerConnection
-- edges =
--     Field.fieldDecoder "edges" [] (Api.Object.StargazerEdge.decoder |> Decode.list)
-- nodes : FieldDecoder (List Api.Object.User) Api.Object.StargazerConnection
-- nodes =
--     Field.fieldDecoder "nodes" [] (Api.Object.User.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.StargazerConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.StargazerConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.int
