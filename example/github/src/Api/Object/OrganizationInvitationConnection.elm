module Api.Object.OrganizationInvitationConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.OrganizationInvitationConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.OrganizationInvitationEdge) Api.Object.OrganizationInvitationConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.OrganizationInvitationEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.OrganizationInvitation) Api.Object.OrganizationInvitationConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.OrganizationInvitation.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.OrganizationInvitationConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.OrganizationInvitationConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
