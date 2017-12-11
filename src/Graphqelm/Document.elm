module Graphqelm.Document exposing (RootMutation, RootQuery, decoderNew, toMutationDocument, toQueryDocument)

import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Object exposing (Object(Object))
import Interpolate exposing (interpolate)
import Json.Decode as Decode exposing (Decoder)


type RootQuery
    = RootQuery


type RootMutation
    = RootMutation


toQueryDocument : Object decodesTo RootQuery -> String
toQueryDocument (Object fields decoder) =
    toDocumentString "query" fields


toMutationDocument : Object decodesTo RootMutation -> String
toMutationDocument (Object fields decoder) =
    toDocumentString "mutation" fields


toDocumentString : String -> List Field -> String
toDocumentString string queries =
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
