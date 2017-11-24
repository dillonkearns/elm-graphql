module GraphqElm.Object exposing (..)

import GraphqElm.Argument exposing (Argument)
import GraphqElm.Field exposing (Field(Composite), FieldDecoder(FieldDecoder))
import Json.Decode as Decode exposing (Decoder)


type Object decodesTo
    = Object (List Field) (Decoder decodesTo)


listOf : String -> List Argument -> Object a -> FieldDecoder (List a)
listOf fieldName args (Object fields decoder) =
    FieldDecoder (Composite fieldName args fields) (Decode.list decoder |> Decode.field fieldName)


single : String -> List Argument -> Object a -> FieldDecoder a
single fieldName args (Object fields decoder) =
    FieldDecoder (Composite fieldName args fields) (decoder |> Decode.field fieldName)


object :
    (a -> constructor)
    -> Object (a -> constructor)
object constructor =
    Object
        []
        (Decode.succeed constructor)


with : FieldDecoder a -> Object (a -> b) -> Object b
with (FieldDecoder field fieldDecoder) (Object objectFields objectDecoder) =
    Object (field :: objectFields) (Decode.map2 (|>) fieldDecoder objectDecoder)
