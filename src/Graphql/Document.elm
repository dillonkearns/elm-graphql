module Graphql.Document exposing
    ( serializeQuery, serializeMutation, serializeSubscription, serializeQueryForUrl, decoder
    , serializeFragment
    )

{-| You'll usually want to use `Graphql.Http` to perform your queries directly.
This package provides low-level functions for generating GraphQL documents that
are helpful for debugging and demo purposes.

@docs serializeQuery, serializeMutation, serializeSubscription, serializeQueryForUrl, decoder

-}

import Graphql.Document.Field as Field
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.RawField exposing (RawField)
import Graphql.SelectionSet exposing (SelectionSet(..))
import Json.Decode as Decode exposing (Decoder)
import String.Interpolate exposing (interpolate)


{-| Serialize a query selection set into a string for a GraphQL endpoint.
-}
serializeQuery : SelectionSet decodesTo RootQuery -> String
serializeQuery (SelectionSet fields decoder_) =
    serialize "query" fields


{-| Serialize a query selection set into a string with minimal whitespace. For
use with a GET request as a query param.
-}
serializeQueryForUrl : SelectionSet decodesTo RootQuery -> String
serializeQueryForUrl (SelectionSet fields decoder_) =
    "{" ++ Field.serializeChildren True Nothing fields ++ "}"


{-| Serialize a mutation selection set into a string for a GraphQL endpoint.
-}
serializeMutation : SelectionSet decodesTo RootMutation -> String
serializeMutation (SelectionSet fields decoder_) =
    serialize "mutation" fields


{-| Serialize a subscription selection set into a string for a GraphQL endpoint.
-}
serializeSubscription : SelectionSet decodesTo RootSubscription -> String
serializeSubscription (SelectionSet fields decoder_) =
    serialize "subscription" fields


{-| Serialize a subscription selection set into a string for a GraphQL endpoint.
-}
serializeFragment : String -> String -> SelectionSet decodesTo selectionContext -> String
serializeFragment fragmentName fragmentType (SelectionSet fields decoder_) =
    interpolate """fragment {0} on {1} {
{1}
}"""
        [ fragmentName, fragmentType, Field.serializeChildren True (Just 0) fields ]


{-| Decoder a response from the server. This low-level function shouldn't be needed
in the majority of cases. Instead, the high-level functions in `Graphql.Http`
should be used.
-}
decoder : SelectionSet decodesTo typeLock -> Decoder decodesTo
decoder (SelectionSet fields decoder_) =
    decoder_ |> Decode.field "data"


serialize : String -> List RawField -> String
serialize operationName queries =
    interpolate """{0} {
{1}
}"""
        [ operationName, Field.serializeChildren True (Just 0) queries ]
