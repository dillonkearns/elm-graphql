module Github.Object.LanguageConnection exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.LanguageConnection
selection constructor =
    Object.object constructor


edges : SelectionSet edges Github.Object.LanguageEdge -> FieldDecoder (List edges) Github.Object.LanguageConnection
edges object =
    Object.listOf "edges" [] object


nodes : SelectionSet nodes Github.Object.Language -> FieldDecoder (List nodes) Github.Object.LanguageConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : SelectionSet pageInfo Github.Object.PageInfo -> FieldDecoder pageInfo Github.Object.LanguageConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Github.Object.LanguageConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int


totalSize : FieldDecoder Int Github.Object.LanguageConnection
totalSize =
    Object.fieldDecoder "totalSize" [] Decode.int
