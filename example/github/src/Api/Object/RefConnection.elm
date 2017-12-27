module Api.Object.RefConnection exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.RefConnection
selection constructor =
    Object.object constructor


edges : SelectionSet edges Api.Object.RefEdge -> FieldDecoder (List edges) Api.Object.RefConnection
edges object =
    Object.listOf "edges" [] object


nodes : SelectionSet nodes Api.Object.Ref -> FieldDecoder (List nodes) Api.Object.RefConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : SelectionSet pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.RefConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.RefConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
