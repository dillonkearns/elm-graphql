module Graphqelm.RootObject exposing (fieldDecoder, listOf, object, single)

import Graphqelm.Argument exposing (Argument)
import Graphqelm.Field exposing (Field, FieldDecoder(FieldDecoder))
import Graphqelm.Object exposing (Object(..))
import Json.Decode as Decode exposing (Decoder)


fieldDecoder : String -> List Argument -> Decoder decodesTo -> FieldDecoder decodesTo lockedTo
fieldDecoder fieldName args decoder =
    FieldDecoder (leaf fieldName args) decoder


listOf : String -> List Argument -> Object a objectTypeLock -> FieldDecoder (List a) lockedTo
listOf fieldName args (Object fields decoder) =
    FieldDecoder (composite fieldName args fields) (Decode.list decoder)


single : String -> List Argument -> Object a objectTypeLock -> FieldDecoder a lockedTo
single fieldName args (Object fields decoder) =
    FieldDecoder (composite fieldName args fields) decoder


composite : String -> List Argument -> List Field -> Field
composite fieldName args fields =
    Graphqelm.Field.QueryField (Graphqelm.Field.Composite fieldName args fields)


leaf : String -> List Argument -> Field
leaf fieldName args =
    Graphqelm.Field.QueryField (Graphqelm.Field.Leaf fieldName args)


object : (a -> constructor) -> Object (a -> constructor) typeLock
object constructor =
    Object [] (Decode.succeed constructor)
