module Api.Object.OrganizationConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.OrganizationConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.OrganizationEdge) Api.Object.OrganizationConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.OrganizationEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.Organization) Api.Object.OrganizationConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.Organization.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.OrganizationConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.OrganizationConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
