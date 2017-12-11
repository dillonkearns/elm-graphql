module Graphqelm.Document exposing (RootMutation, RootQuery, decoderNew, toMutationDocument, toQueryDocument, toQueryNew)

import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Object exposing (Object(Object))
import Interpolate exposing (interpolate)
import Json.Decode as Decode exposing (Decoder)


type RootQuery
    = RootQuery


type RootMutation
    = RootMutation


toQueryNew : Object decodesTo typeLock -> String
toQueryNew (Object fields decoder) =
    queriesStringNew "" fields


toQueryDocument : Object decodesTo RootQuery -> String
toQueryDocument (Object fields decoder) =
    queriesStringNew "query" fields


toMutationDocument : Object decodesTo RootMutation -> String
toMutationDocument (Object fields decoder) =
    queriesStringNew "mutation" fields


queriesStringNew : String -> List Field -> String
queriesStringNew string queries =
    string
        ++ " {\n"
        ++ (List.indexedMap
                (\index query ->
                    interpolate "  {0}: {1}"
                        [ "result" ++ toString (index + 1), Field.fieldDecoderToQuery True 1 query ]
                )
                queries
                |> String.join "\n"
           )
        ++ "\n}"


decoderNew : Object decodesTo typeLock -> Decoder decodesTo
decoderNew (Object fields decoder) =
    decoder
        |> Decode.field "data"
