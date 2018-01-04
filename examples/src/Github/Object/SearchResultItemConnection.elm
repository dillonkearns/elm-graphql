module Github.Object.SearchResultItemConnection exposing (..)

import Github.Interface
import Github.Object
import Github.Union
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


{-| The number of pieces of code that matched the search query.
-}
codeCount : FieldDecoder Int Github.Object.SearchResultItemConnection
codeCount =
    Object.fieldDecoder "codeCount" [] Decode.int


{-| A list of edges.
-}
edges : SelectionSet edges Github.Object.SearchResultItemEdge -> FieldDecoder (Maybe (List (Maybe edges))) Github.Object.SearchResultItemConnection
edges object =
    Object.selectionFieldDecoder "edges" [] object (identity >> Decode.maybe >> Decode.list >> Decode.maybe)


{-| The number of issues that matched the search query.
-}
issueCount : FieldDecoder Int Github.Object.SearchResultItemConnection
issueCount =
    Object.fieldDecoder "issueCount" [] Decode.int


{-| A list of nodes.
-}
nodes : SelectionSet nodes Github.Union.SearchResultItem -> FieldDecoder (Maybe (List (Maybe nodes))) Github.Object.SearchResultItemConnection
nodes object =
    Object.selectionFieldDecoder "nodes" [] object (identity >> Decode.maybe >> Decode.list >> Decode.maybe)


{-| Information to aid in pagination.
-}
pageInfo : SelectionSet pageInfo Github.Object.PageInfo -> FieldDecoder pageInfo Github.Object.SearchResultItemConnection
pageInfo object =
    Object.selectionFieldDecoder "pageInfo" [] object identity


{-| The number of repositories that matched the search query.
-}
repositoryCount : FieldDecoder Int Github.Object.SearchResultItemConnection
repositoryCount =
    Object.fieldDecoder "repositoryCount" [] Decode.int


{-| The number of users that matched the search query.
-}
userCount : FieldDecoder Int Github.Object.SearchResultItemConnection
userCount =
    Object.fieldDecoder "userCount" [] Decode.int


{-| The number of wiki pages that matched the search query.
-}
wikiCount : FieldDecoder Int Github.Object.SearchResultItemConnection
wikiCount =
    Object.fieldDecoder "wikiCount" [] Decode.int
