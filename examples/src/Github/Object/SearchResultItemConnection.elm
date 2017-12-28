module Github.Object.SearchResultItemConnection exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.SearchResultItemConnection
selection constructor =
    Object.object constructor


codeCount : FieldDecoder Int Github.Object.SearchResultItemConnection
codeCount =
    Object.fieldDecoder "codeCount" [] Decode.int


edges : SelectionSet edges Github.Object.SearchResultItemEdge -> FieldDecoder (List edges) Github.Object.SearchResultItemConnection
edges object =
    Object.selectionFieldDecoder "edges" [] object (identity >> Decode.list)


issueCount : FieldDecoder Int Github.Object.SearchResultItemConnection
issueCount =
    Object.fieldDecoder "issueCount" [] Decode.int


nodes : FieldDecoder (List String) Github.Object.SearchResultItemConnection
nodes =
    Object.fieldDecoder "nodes" [] (Decode.string |> Decode.list)


pageInfo : SelectionSet pageInfo Github.Object.PageInfo -> FieldDecoder pageInfo Github.Object.SearchResultItemConnection
pageInfo object =
    Object.selectionFieldDecoder "pageInfo" [] object identity


repositoryCount : FieldDecoder Int Github.Object.SearchResultItemConnection
repositoryCount =
    Object.fieldDecoder "repositoryCount" [] Decode.int


userCount : FieldDecoder Int Github.Object.SearchResultItemConnection
userCount =
    Object.fieldDecoder "userCount" [] Decode.int


wikiCount : FieldDecoder Int Github.Object.SearchResultItemConnection
wikiCount =
    Object.fieldDecoder "wikiCount" [] Decode.int
