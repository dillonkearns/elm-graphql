module Graphqelm.Document exposing (Operation(Mutation, Query, Subscription), decoder, serialize, serializeMutation, serializeQuery, serializeQueryForUrl, serializeSubscription)

{-| You'll usually want to use `Graphqelm.Http` to perform your queries directly.
This package provides low-level functions for generating GraphQL documents that
are helpful for debugging and demo purposes.

@docs Operation, serialize, serializeQuery, serializeMutation, serializeSubscription, serializeQueryForUrl, decoder

-}

import Graphqelm.Document.Field as Field
import Graphqelm.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphqelm.RawField exposing (RawField)
import Graphqelm.SelectionSet exposing (SelectionSet(SelectionSet))
import Json.Decode as Decode exposing (Decoder)
import String.Interpolate exposing (interpolate)


{-| An enum used to describe the type of operation for use in `serialize`.
-}
type Operation
    = Query
    | Mutation
    | Subscription


{-| Serialize a query selection set into a string for a GraphQL endpoint.
-}
serializeQuery : SelectionSet decodesTo RootQuery -> String
serializeQuery selection =
    serialize Query selection


{-| Serialize a query selection set into a string with minimal whitespace. For
use with a GET request as a query param.
-}
serializeQueryForUrl : SelectionSet decodesTo RootQuery -> String
serializeQueryForUrl (SelectionSet fields decoder) =
    "{" ++ Field.serializeChildren Nothing fields ++ "}"


{-| Serialize a mutation selection set into a string for a GraphQL endpoint.
-}
serializeMutation : SelectionSet decodesTo RootMutation -> String
serializeMutation selection =
    serialize Mutation selection


{-| Serialize a subscription selection set into a string for a GraphQL endpoint.
-}
serializeSubscription : SelectionSet decodesTo RootSubscription -> String
serializeSubscription selection =
    serialize Subscription selection


{-| Decoder a response from the server. This low-level function shouldn't be needed
in the majority of cases. Instead, the high-level functions in `Graphqelm.Http`
should be used.
-}
decoder : SelectionSet decodesTo typeLock -> Decoder decodesTo
decoder (SelectionSet fields decoder) =
    decoder |> Decode.field "data"


{-| Serialize any type of selection set into a string for a GraphQL endpoint.
This is useful if you're writing a function that operates on any type of
selection set that needs to serialize its results.
-}
serialize : Operation -> SelectionSet decodesTo typeLock -> String
serialize operation (SelectionSet fields _) =
    let
        operationName =
            case operation of
                Query ->
                    "query"

                Mutation ->
                    "mutation"

                Subscription ->
                    "subscription"
    in
    interpolate """{0} {
{1}
}"""
        [ operationName, Field.serializeChildren (Just 0) fields ]
