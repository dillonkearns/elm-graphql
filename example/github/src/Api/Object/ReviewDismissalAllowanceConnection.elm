module Api.Object.ReviewDismissalAllowanceConnection exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.ReviewDismissalAllowanceConnection
selection constructor =
    Object.object constructor


edges : SelectionSet edges Api.Object.ReviewDismissalAllowanceEdge -> FieldDecoder (List edges) Api.Object.ReviewDismissalAllowanceConnection
edges object =
    Object.listOf "edges" [] object


nodes : SelectionSet nodes Api.Object.ReviewDismissalAllowance -> FieldDecoder (List nodes) Api.Object.ReviewDismissalAllowanceConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : SelectionSet pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.ReviewDismissalAllowanceConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.ReviewDismissalAllowanceConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
