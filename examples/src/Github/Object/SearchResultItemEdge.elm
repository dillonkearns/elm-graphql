module Github.Object.SearchResultItemEdge exposing (..)

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


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.SearchResultItemEdge
selection constructor =
    Object.object constructor


{-| A cursor for use in pagination.
-}
cursor : FieldDecoder String Github.Object.SearchResultItemEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


{-| The item at the end of the edge.
-}
node : SelectionSet node Github.Union.SearchResultItem -> FieldDecoder (Maybe node) Github.Object.SearchResultItemEdge
node object =
    Object.selectionFieldDecoder "node" [] object (identity >> Decode.maybe)


{-| Text matches on the result found.
-}
textMatches : SelectionSet textMatches Github.Object.TextMatch -> FieldDecoder (Maybe (List (Maybe textMatches))) Github.Object.SearchResultItemEdge
textMatches object =
    Object.selectionFieldDecoder "textMatches" [] object (identity >> Decode.maybe >> Decode.list >> Decode.maybe)
