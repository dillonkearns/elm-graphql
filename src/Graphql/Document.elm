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


{-| append user define operationName.
-}
appendOperationName : String -> Maybe String -> String
appendOperationName operation name =
    name
        |> Maybe.map (\name_ -> operation ++ " " ++ name_)
        |> Maybe.withDefault operation


{-| Serialize a query selection set into a string for a GraphQL endpoint.
-}
serializeQuery : Maybe String -> SelectionSet decodesTo RootQuery -> String
serializeQuery operationName (SelectionSet fields decoder_) =
    serialize
        (appendOperationName
            "query"
            operationName
        )
        fields


{-| Serialize a query selection set into a string with minimal whitespace. For
use with a GET request as a query param.
-}
serializeQueryForUrl : SelectionSet decodesTo RootQuery -> String
serializeQueryForUrl (SelectionSet fields decoder_) =
    "{" ++ Field.serializeChildren Nothing fields ++ "}"


{-| Serialize a mutation selection set into a string for a GraphQL endpoint.
-}
serializeMutation : Maybe String -> SelectionSet decodesTo RootMutation -> String
serializeMutation operationName (SelectionSet fields decoder_) =
    serialize
        (appendOperationName
            "mutation"
            operationName
        )
        fields


{-| Serialize a subscription selection set into a string for a GraphQL endpoint.
-}
serializeSubscription : SelectionSet decodesTo RootSubscription -> String
serializeSubscription (SelectionSet fields decoder_) =
    serialize "subscription" fields


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
        [ operationName, Field.serializeChildren (Just 0) queries ]
