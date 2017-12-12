module Graphqelm.QuerySerializer exposing (serializeMutation, serializeQuery)

import Graphqelm.Document exposing (RootMutation, RootQuery)
import Graphqelm.Field exposing (Field)
import Graphqelm.Object exposing (Object(Object))
import Graphqelm.QuerySerializer.Field as Field
import Interpolate exposing (interpolate)


serializeQuery : Object decodesTo RootQuery -> String
serializeQuery (Object fields decoder) =
    serialize "query" fields


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
