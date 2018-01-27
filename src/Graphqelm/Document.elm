module Graphqelm.Document exposing (serializeMutation, serializeQuery, serializeQueryForUrl, serializeSubscription)

{-| You'll usually want to use `Graphqelm.Http` to perform your queries directly.
This package provides low-level functions for generating GraphQL documents that
are helpful for debugging and demo purposes.

@docs serializeQuery, serializeMutation, serializeSubscription, serializeQueryForUrl

-}

import Graphqelm.Document.Field as Field
import Graphqelm.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphqelm.RawField exposing (RawField)
import Graphqelm.SelectionSet exposing (SelectionSet(SelectionSet))
import Interpolate exposing (interpolate)


{-| Serialize a query selection set into a string for a GraphQL endpoint.
-}
serializeQuery : SelectionSet decodesTo RootQuery -> String
serializeQuery (SelectionSet fields decoder) =
    serialize "query" fields


{-| Serialize a query selection set into a string with minimal whitespace. For
use with a GET request as a query param.
-}
serializeQueryForUrl : SelectionSet decodesTo RootQuery -> String
serializeQueryForUrl (SelectionSet fields decoder) =
    "{" ++ Field.serializeChildren Nothing fields ++ "}"


{-| Serialize a mutation selection set into a string for a GraphQL endpoint.
-}
serializeMutation : SelectionSet decodesTo RootMutation -> String
serializeMutation (SelectionSet fields decoder) =
    serialize "mutation" fields


{-| Serialize a subscription selection set into a string for a GraphQL endpoint.
-}
serializeSubscription : SelectionSet decodesTo RootSubscription -> String
serializeSubscription (SelectionSet fields decoder) =
    serialize "subscription" fields


serialize : String -> List RawField -> String
serialize operationName queries =
    interpolate """{0} {
{1}
}"""
        [ operationName, Field.serializeChildren (Just 0) queries ]
