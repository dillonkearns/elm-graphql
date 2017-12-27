module Api.Object.TeamMemberConnection exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.TeamMemberConnection
selection constructor =
    Object.object constructor


edges : SelectionSet edges Api.Object.TeamMemberEdge -> FieldDecoder (List edges) Api.Object.TeamMemberConnection
edges object =
    Object.listOf "edges" [] object


nodes : SelectionSet nodes Api.Object.User -> FieldDecoder (List nodes) Api.Object.TeamMemberConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : SelectionSet pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.TeamMemberConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.TeamMemberConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
