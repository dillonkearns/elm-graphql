module Graphqelm.Builder.Object exposing (fieldDecoder, listOf, object, single)

{-| Internal functions for use by auto-generated code from the `graphqelm` CLI.
@docs fieldDecoder, listOf, object, single
-}

import Graphqelm.Builder.Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder(FieldDecoder))
import Graphqelm.Object exposing (Object(Object))
import Json.Decode as Decode exposing (Decoder)


{-| Refer to a field in auto-generated code.
-}
fieldDecoder : String -> List Argument -> Decoder decodesTo -> FieldDecoder decodesTo lockedTo
fieldDecoder fieldName args decoder =
    FieldDecoder (Field.Leaf fieldName args)
        (decoder |> Decode.field fieldName)


{-| Refer to list of objects in auto-generated code.
-}
listOf : String -> List Argument -> Object a objectTypeLock -> FieldDecoder (List a) lockedTo
listOf fieldName args (Object fields decoder) =
    FieldDecoder (Field.Composite fieldName args fields) (Decode.list decoder |> Decode.field fieldName)


{-| Refer to single object in auto-generated code.
-}
single : String -> List Argument -> Object a objectTypeLock -> FieldDecoder a lockedTo
single fieldName args (Object fields decoder) =
    FieldDecoder (Field.Composite fieldName args fields) (decoder |> Decode.field fieldName)


{-| Used to create the `selection` functions in auto-generated code.
-}
object : (a -> constructor) -> Object (a -> constructor) typeLock
object constructor =
    Object [] (Decode.succeed constructor)
