module Github.Object.ReviewDismissalAllowanceConnection exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ReviewDismissalAllowanceConnection
selection constructor =
    Object.object constructor


{-| A list of edges.
-}
edges : SelectionSet edges Github.Object.ReviewDismissalAllowanceEdge -> FieldDecoder (Maybe (List (Maybe edges))) Github.Object.ReviewDismissalAllowanceConnection
edges object =
    Object.selectionFieldDecoder "edges" [] object (identity >> Decode.maybe >> Decode.list >> Decode.maybe)


{-| A list of nodes.
-}
nodes : SelectionSet nodes Github.Object.ReviewDismissalAllowance -> FieldDecoder (Maybe (List (Maybe nodes))) Github.Object.ReviewDismissalAllowanceConnection
nodes object =
    Object.selectionFieldDecoder "nodes" [] object (identity >> Decode.maybe >> Decode.list >> Decode.maybe)


{-| Information to aid in pagination.
-}
pageInfo : SelectionSet pageInfo Github.Object.PageInfo -> FieldDecoder pageInfo Github.Object.ReviewDismissalAllowanceConnection
pageInfo object =
    Object.selectionFieldDecoder "pageInfo" [] object identity


{-| Identifies the total count of items in the connection.
-}
totalCount : FieldDecoder Int Github.Object.ReviewDismissalAllowanceConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
