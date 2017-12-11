module Graphqelm.Document exposing (DocumentQueryOrMutation, DocumentRoot, RootMutation, RootQuery, combine, decoder, decoderNew, mutationField, queryField, toQuery, toQueryNew)

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


type DocumentRoot decodesTo
    = DocumentRoot (List DocumentField) (Decoder decodesTo)


type DocumentQueryOrMutation
    = DocumentQueryOrMutation


query : Object decodesTo RootQuery -> FieldDecoder decodesTo DocumentQueryOrMutation
query (Object fields decoder) =
    -- TODO: should the Decode.field logic happen here?
    FieldDecoder (Field.Composite "query" [] fields) decoder


queryField : FieldDecoder decodesTo lockedTo -> DocumentRoot decodesTo
queryField (FieldDecoder field decoder) =
    DocumentRoot [ DocumentField QueryField field ] decoder


mutationField : FieldDecoder decodesTo lockedTo -> DocumentRoot decodesTo
mutationField (FieldDecoder field decoder) =
    DocumentRoot [ DocumentField MutationField field ] decoder


separate : DocumentRoot decodesTo -> { queries : List Field, mutations : List Field }
separate (DocumentRoot documentFields decoder) =
    List.foldl
        (\(DocumentField mutationOrQuery field) soFar ->
            let
                _ =
                    Debug.log "foldl" mutationOrQuery
            in
            case mutationOrQuery of
                QueryField ->
                    { soFar | queries = soFar.queries ++ [ field ] }

                MutationField ->
                    { soFar | mutations = soFar.mutations ++ [ field ] }
        )
        { queries = [], mutations = [] }
        documentFields
        |> Debug.log "result"


separateNew : Field -> List Field
separateNew field =
    case field of
        Field.Composite name args fields ->
            [ field ]

        -- fields
        Field.Leaf name args ->
            [ field ]


toQueryNew : Object decodesTo typeLock -> String
toQueryNew (Object fields decoder) =
    queriesStringNew fields
        ++ "\n\n"
        ++ mutationsStringNew fields


toQuery : DocumentRoot a -> String
toQuery document =
    queriesString (separate document)
        ++ "\n\n"
        ++ mutationsString (separate document)


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


decoder : DocumentRoot decodesTo -> Decoder decodesTo
decoder (DocumentRoot fields decoder) =
    (case fields of
        [ DocumentField QueryField singleField ] ->
            Decode.field "query0" decoder

        [ DocumentField MutationField singleField ] ->
            Decode.field "mutation0" decoder

        multipleFields ->
            decoder
    )
        |> Decode.field "data"


combine : (decodesToA -> decodesToB -> decodesToC) -> DocumentRoot decodesToA -> DocumentRoot decodesToB -> DocumentRoot decodesToC
combine combineFunction (DocumentRoot fieldsA decoderA) (DocumentRoot fieldsB decoderB) =
    case ( fieldsA, fieldsB ) of
        ( [ singleA ], [ singleB ] ) ->
            DocumentRoot (fieldsA ++ fieldsB) (Decode.map2 combineFunction (Decode.field "query0" decoderA) (Decode.field "query1" decoderB))

        ( [ singleA ], multipleB ) ->
            DocumentRoot (fieldsB ++ fieldsA) (Decode.map2 combineFunction (Decode.field ("query" ++ toString (List.length fieldsB)) decoderA) decoderB)

        ( multipleA, [ singleB ] ) ->
            DocumentRoot (fieldsA ++ fieldsB) (Decode.map2 combineFunction decoderA (Decode.field ("query" ++ toString (List.length fieldsA)) decoderB))

        ( multipleA, multipleB ) ->
            DocumentRoot (fieldsA ++ fieldsB) (Decode.map2 combineFunction decoderA decoderB)
