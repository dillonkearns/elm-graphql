module Graphqelm.Object exposing (Object(Object), with)

import Graphqelm.Field as Field exposing (Field)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder(FieldDecoder))
import Json.Decode as Decode exposing (Decoder)


type Object decodesTo typeLock
    = Object (List Field) (Decoder decodesTo)


with : FieldDecoder a typeLock -> Object (a -> b) typeLock -> Object b typeLock
with (FieldDecoder field fieldDecoder) (Object objectFields objectDecoder) =
    case field of
        Field.QueryField nestedField ->
            let
                n =
                    List.length objectFields
            in
            Object (objectFields ++ [ nestedField ])
                (Decode.map2 (|>)
                    (Decode.field ("result" ++ toString (n + 1)) fieldDecoder)
                    objectDecoder
                )

        _ ->
            Object (field :: objectFields) (Decode.map2 (|>) fieldDecoder objectDecoder)
