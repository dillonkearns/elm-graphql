module Graphqelm.DocumentSerializer exposing (serializeMutation, serializeQuery)

{-| You'll usually want to use `Graphqelm.Http` to perform your queries directly.
This package provides low-level functions for generating GraphQL documents that
are helpful for debugging and demo purposes.

@docs serializeQuery, serializeMutation

-}

import Graphqelm exposing (RootMutation, RootQuery)
import Graphqelm.DocumentSerializer.Field as Field
import Graphqelm.Field exposing (Field)
import Graphqelm.Object exposing (Object(Object))
import Interpolate exposing (interpolate)


{-| Serialize a query object into a string for a GraphQL endpoint.
-}
serializeQuery : Object decodesTo RootQuery -> String
serializeQuery (Object fields decoder) =
    serialize "query" fields


{-| Serialize a mutation object into a string for a GraphQL endpoint.
-}
serializeMutation : Object decodesTo RootMutation -> String
serializeMutation (Object fields decoder) =
    serialize "mutation" fields


serialize : String -> List Field -> String
serialize string queries =
    string
        ++ " {\n"
        ++ (List.indexedMap
                (\index query ->
                    interpolate "  {0}: {1}"
                        [ "result" ++ toString (index + 1), Field.serialize True 1 query ]
                )
                queries
                |> String.join "\n"
           )
        ++ "\n}"
