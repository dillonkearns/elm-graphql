module Graphqelm.DocumentSerializer exposing (serializeMutation, serializeQuery)

{-| TODO
@docs serializeQuery, serializeMutation
-}

import Graphqelm exposing (RootMutation, RootQuery)
import Graphqelm.DocumentSerializer.Field as Field
import Graphqelm.Field exposing (Field)
import Graphqelm.Object exposing (Object(Object))
import Interpolate exposing (interpolate)


{-| TODO
-}
serializeQuery : Object decodesTo RootQuery -> String
serializeQuery (Object fields decoder) =
    serialize "query" fields


{-| TODO
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
