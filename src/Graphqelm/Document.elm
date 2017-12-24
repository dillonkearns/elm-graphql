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
import List.Extra


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
    operationName
        ++ " {\n"
        ++ (List.indexedMap
                (\index query ->
                    case alias index queries query of
                        Just aliasName ->
                            interpolate "  {0}: {1}"
                                [ aliasName, Field.serialize True 1 query ]

                        Nothing ->
                            "  " ++ Field.serialize True 1 query
                )
                queries
                |> String.join "\n"
           )
        ++ "\n}"


alias : Int -> List Field -> Field -> Maybe String
alias fieldIndex fields field =
    let
        fieldName =
            Graphqelm.Field.name field

        indices =
            fields
                |> List.Extra.findIndices
                    (\currentField ->
                        fieldName
                            == Graphqelm.Field.name currentField
                    )
                |> List.filter (\index -> index < fieldIndex)
    in
    if indices == [] then
        Nothing
    else
        Just (fieldName ++ toString (List.length indices + 1))
