module Graphql.Document exposing (serializeQuery, serializeMutation, serializeSubscription, serializeQueryForUrl, decoder)

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
serializeQuery : Maybe String -> SelectionSet decodesTo RootQuery -> String
serializeQuery maybeOperationName (SelectionSet fields decoder_) =
    serialize maybeOperationName "query" fields


{-| Serialize a query selection set into a string with minimal whitespace. For
use with a GET request as a query param.
-}
serializeQueryForUrl : Maybe String -> SelectionSet decodesTo RootQuery -> String
serializeQueryForUrl maybeOperationName (SelectionSet fields decoder_) =
    case maybeOperationName of
        Just operationName ->
            "query " ++ operationName ++ " {" ++ Field.serializeChildren Nothing fields ++ "}"

        Nothing ->
            "{" ++ Field.serializeChildren Nothing fields ++ "}"


{-| Serialize a mutation selection set into a string for a GraphQL endpoint.
-}
serializeMutation : Maybe String -> SelectionSet decodesTo RootMutation -> String
serializeMutation maybeOperationName (SelectionSet fields decoder_) =
    serialize maybeOperationName "mutation" fields


{-| Serialize a subscription selection set into a string for a GraphQL endpoint.
-}
serializeSubscription : Maybe String -> SelectionSet decodesTo RootSubscription -> String
serializeSubscription maybeOperationName (SelectionSet fields decoder_) =
    serialize maybeOperationName "subscription" fields


{-| Decoder a response from the server. This low-level function shouldn't be needed
in the majority of cases. Instead, the high-level functions in `Graphql.Http`
should be used.
-}
decoder : SelectionSet decodesTo typeLock -> Decoder decodesTo
decoder (SelectionSet fields decoder_) =
    decoder_ |> Decode.field "data"


serialize : Maybe String -> String -> List RawField -> String
serialize operationName operationType queries =
    interpolate """{0} {
{1}
}"""
        [ [ Just operationType, operationName ]
            |> List.filterMap identity
            |> String.join " "
        , Field.serializeChildren (Just 0) queries
        ]
