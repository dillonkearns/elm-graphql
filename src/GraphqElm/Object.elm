module Graphqelm.Object exposing (..)

import Graphqelm.Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder(FieldDecoder))
import Json.Decode as Decode exposing (Decoder)


type Object decodesTo typeLock
    = Object (List Field) (Decoder decodesTo)


fieldDecoder : String -> List Argument -> Decoder decodesTo -> FieldDecoder decodesTo lockedTo
fieldDecoder fieldName args decoder =
    FieldDecoder (Field.Leaf fieldName args)
        (decoder |> Decode.field fieldName)


listOf : String -> List Argument -> Object a objectTypeLock -> FieldDecoder (List a) lockedTo
listOf fieldName args (Object fields decoder) =
    FieldDecoder (Field.Composite fieldName args fields) (Decode.list decoder |> Decode.field fieldName)


single : String -> List Argument -> Object a objectTypeLock -> FieldDecoder a lockedTo
single fieldName args (Object fields decoder) =
    FieldDecoder (Field.Composite fieldName args fields) (decoder |> Decode.field fieldName)


object : (a -> constructor) -> Object (a -> constructor) typeLock
object constructor =
    Object [] (Decode.succeed constructor)


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
                    (Decode.field ("result" ++ toString n) fieldDecoder)
                    objectDecoder
                )

        _ ->
            Object (field :: objectFields) (Decode.map2 (|>) fieldDecoder objectDecoder)
