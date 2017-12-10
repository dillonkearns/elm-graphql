module Graphqelm.Query exposing (fieldDecoder, listOf, single)

import Graphqelm.Argument exposing (Argument)
import Graphqelm.Document as Document exposing (RootField)
import Graphqelm.Field as Field exposing (Field(Composite), FieldDecoder(FieldDecoder))
import Graphqelm.Object exposing (Object(..))
import Json.Decode as Decode exposing (Decoder)


single : String -> List Argument -> Object a objectTypeLock -> RootField a
single fieldName args (Object fields decoder) =
    FieldDecoder (Composite fieldName args fields) decoder
        |> rootQuery


listOf : String -> List Argument -> Object a objectTypeLock -> RootField (List a)
listOf fieldName args (Object fields decoder) =
    FieldDecoder (Composite fieldName args fields) (Decode.list decoder)
        |> rootQuery


fieldDecoder : String -> List Argument -> Decoder decodesTo -> RootField decodesTo
fieldDecoder fieldName args decoder =
    FieldDecoder (Field.Leaf fieldName args) decoder
        |> rootQuery


rootQuery : FieldDecoder decodesTo lockedTo -> RootField decodesTo
rootQuery fieldDecoder =
    Document.queryField fieldDecoder
