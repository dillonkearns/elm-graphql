module Graphqelm.Query exposing (Query, combine, decoder, fieldDecoder, listOf, single, toQuery)

import Graphqelm.Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field(Composite), FieldDecoder(FieldDecoder))
import Graphqelm.Object exposing (Object(..))
import Json.Decode as Decode exposing (Decoder)


type DocumentField
    = DocumentField MutationOrQuery Field


type MutationOrQuery
    = QueryField
    | MutationField


type Query decodesTo
    = Query (List DocumentField) (Decoder decodesTo)


toQuery : Query a -> String
toQuery (Query fields decoder) =
    "query {\n"
        ++ (List.indexedMap (\index (DocumentField mutationOrQuery field) -> "query" ++ toString index ++ ": " ++ Field.fieldDecoderToQuery field) fields |> String.join "\n")
        ++ "\n}"


decoder : Query decodesTo -> Decoder decodesTo
decoder (Query fields decoder) =
    (case fields of
        [ singleField ] ->
            Decode.field "query0" decoder

        multipleFields ->
            decoder
    )
        |> Decode.field "data"


single : String -> List Argument -> Object a objectTypeLock -> Query a
single fieldName args (Object fields decoder) =
    FieldDecoder (Composite fieldName args fields) decoder
        |> rootQuery


listOf : String -> List Argument -> Object a objectTypeLock -> Query (List a)
listOf fieldName args (Object fields decoder) =
    FieldDecoder (Composite fieldName args fields) (Decode.list decoder)
        |> rootQuery


fieldDecoder : String -> List Argument -> Decoder decodesTo -> Query decodesTo
fieldDecoder fieldName args decoder =
    FieldDecoder (Field.Leaf fieldName args) decoder
        |> rootQuery


combine : (decodesToA -> decodesToB -> decodesToC) -> Query decodesToA -> Query decodesToB -> Query decodesToC
combine combineFunction (Query fieldsA decoderA) (Query fieldsB decoderB) =
    case ( fieldsA, fieldsB ) of
        ( [ singleA ], [ singleB ] ) ->
            Query (fieldsA ++ fieldsB) (Decode.map2 combineFunction (Decode.field "query0" decoderA) (Decode.field "query1" decoderB))

        ( [ singleA ], multipleB ) ->
            Query (fieldsB ++ fieldsA) (Decode.map2 combineFunction (Decode.field ("query" ++ toString (List.length fieldsB)) decoderA) decoderB)

        ( multipleA, [ singleB ] ) ->
            Query (fieldsA ++ fieldsB) (Decode.map2 combineFunction decoderA (Decode.field ("query" ++ toString (List.length fieldsA)) decoderB))

        ( multipleA, multipleB ) ->
            Query (fieldsA ++ fieldsB) (Decode.map2 combineFunction decoderA decoderB)



-- combine3 : (decodesToA -> decodesToB -> decodesToC -> result) -> Query decodesToA -> Query decodesToB -> Query decodesToC -> Query result
-- combine3 combineFunction (Query fieldsA decoderA) (Query fieldsB decoderB) (Query fieldsC decoderC) =
--     Query (fieldsA ++ fieldsB ++ fieldsC) (Decode.map3 combineFunction decoderA decoderB decoderC)


rootQuery : FieldDecoder decodesTo lockedTo -> Query decodesTo
rootQuery (FieldDecoder field decoder) =
    Query [ DocumentField QueryField field ] decoder
