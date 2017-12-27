module Api.Object.StarredRepositoryConnection exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.StarredRepositoryConnection
selection constructor =
    Object.object constructor


edges : SelectionSet edges Api.Object.StarredRepositoryEdge -> FieldDecoder (List edges) Api.Object.StarredRepositoryConnection
edges object =
    Object.listOf "edges" [] object


nodes : SelectionSet nodes Api.Object.Repository -> FieldDecoder (List nodes) Api.Object.StarredRepositoryConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : SelectionSet pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.StarredRepositoryConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.StarredRepositoryConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
