module Graphqelm.Document exposing (serializeMutation, serializeQuery)

{-| You'll usually want to use `Graphqelm.Http` to perform your queries directly.
This package provides low-level functions for generating GraphQL documents that
are helpful for debugging and demo purposes.

@docs serializeQuery, serializeMutation

-}

import Graphqelm exposing (RootMutation, RootQuery)
import Graphqelm.Document.Field as Field
import Graphqelm.Field exposing (Field)
import Graphqelm.SelectionSet exposing (SelectionSet(SelectionSet))
import Interpolate exposing (interpolate)


{-| Serialize a query selection set into a string for a GraphQL endpoint.
-}
serializeQuery : SelectionSet decodesTo RootQuery -> String
serializeQuery (SelectionSet fields decoder) =
    serialize "query" fields


{-| Serialize a mutation selection set into a string for a GraphQL endpoint.
-}
serializeMutation : SelectionSet decodesTo RootMutation -> String
serializeMutation (SelectionSet fields decoder) =
    serialize "mutation" fields


serialize : String -> List Field -> String
serialize operationName queries =
    interpolate """{0} {
{1}
}"""
        [ operationName, Field.serializeChildren -1 queries ]
