module Github.Object.OrganizationInvitationConnection exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.OrganizationInvitationConnection
selection constructor =
    Object.object constructor


edges : SelectionSet edges Github.Object.OrganizationInvitationEdge -> FieldDecoder (Maybe (List (Maybe edges))) Github.Object.OrganizationInvitationConnection
edges object =
    Object.selectionFieldDecoder "edges" [] object (identity >> Decode.maybe >> Decode.list >> Decode.maybe)


nodes : SelectionSet nodes Github.Object.OrganizationInvitation -> FieldDecoder (Maybe (List (Maybe nodes))) Github.Object.OrganizationInvitationConnection
nodes object =
    Object.selectionFieldDecoder "nodes" [] object (identity >> Decode.maybe >> Decode.list >> Decode.maybe)


pageInfo : SelectionSet pageInfo Github.Object.PageInfo -> FieldDecoder pageInfo Github.Object.OrganizationInvitationConnection
pageInfo object =
    Object.selectionFieldDecoder "pageInfo" [] object identity


totalCount : FieldDecoder Int Github.Object.OrganizationInvitationConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
