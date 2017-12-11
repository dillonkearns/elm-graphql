module Graphqelm.Document exposing (DocumentQueryOrMutation, RootMutation, RootQuery, decoderNew, toQueryNew)

import Graphqelm.Field as Field exposing (Field(Composite), FieldDecoder(FieldDecoder))
import Graphqelm.Object exposing (Object(Object))
import Json.Decode as Decode exposing (Decoder)


type RootQuery
    = RootQuery


type RootMutation
    = RootMutation


type DocumentField
    = DocumentField MutationOrQuery Field


type MutationOrQuery
    = QueryField
    | MutationField


type DocumentQueryOrMutation
    = DocumentQueryOrMutation


query : Object decodesTo RootQuery -> FieldDecoder decodesTo DocumentQueryOrMutation
query (Object fields decoder) =
    -- TODO: should the Decode.field logic happen here?
    FieldDecoder (Field.Composite "query" [] fields) decoder


separateNew : Field -> List Field
separateNew field =
    case field of
        Field.Composite name args fields ->
            [ field ]

        -- fields
        Field.Leaf name args ->
            [ field ]

        Field.QueryField field ->
            separateNew field


toQueryNew : Object decodesTo typeLock -> String
toQueryNew (Object fields decoder) =
    queriesStringNew fields
        ++ "\n\n"
        ++ mutationsStringNew fields


queriesString : { document | queries : List Field } -> String
queriesString { queries } =
    if queries == [] then
        ""
    else
        "query {\n"
            ++ (List.indexedMap (\index query -> "query" ++ toString index ++ ": " ++ Field.fieldDecoderToQuery query) queries |> String.join "\n")
            ++ "\n}"



-- queriesStringNew : { document | queries : List Field } -> String


queriesStringNew : List Field -> String
queriesStringNew queries =
    if queries == [] then
        ""
    else
        "query {\n"
            ++ (List.indexedMap (\index query -> "query" ++ toString index ++ ": " ++ Field.fieldDecoderToQuery query) queries |> String.join "\n")
            ++ "\n}"


mutationsStringNew : a -> String
mutationsStringNew field =
    ""



-- if queries == [] then
--     ""
-- else
--     "query {\n"
--         ++ (List.indexedMap (\index query -> "query" ++ toString index ++ ": " ++ Field.fieldDecoderToQuery query) queries |> String.join "\n")
--         ++ "\n}"


mutationsString : { document | mutations : List Field } -> String
mutationsString { mutations } =
    if mutations == [] then
        ""
    else
        "mutation {\n"
            ++ (List.indexedMap (\index query -> "mutation" ++ toString index ++ ": " ++ Field.fieldDecoderToQuery query) mutations |> String.join "\n")
            ++ "\n}"


decoderNew : Object decodesTo typeLock -> Decoder decodesTo
decoderNew (Object fields decoder) =
    -- decoder
    (case fields of
        [ singleField ] ->
            Decode.field "query0" decoder

        multipleFields ->
            decoder
    )
        |> Decode.field "data"
