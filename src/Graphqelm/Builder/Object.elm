module Graphqelm.Builder.Object exposing (fieldDecoder, listOf, object, single)

{-| Internal functions for use by auto-generated code from the `graphqelm` CLI.
@docs fieldDecoder, listOf, object, single
-}

import Graphqelm.Builder.Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder(FieldDecoder))
import Graphqelm.SelectionSet exposing (SelectionSet(SelectionSet))
import Json.Decode as Decode exposing (Decoder)


{-| Refer to a field in auto-generated code.
-}
fieldDecoder : String -> List Argument -> Decoder decodesTo -> FieldDecoder decodesTo lockedTo
fieldDecoder fieldName args decoder =
    FieldDecoder (Field.Leaf fieldName args)
        (decoder |> Decode.field fieldName)


{-| Refer to list of objects in auto-generated code.
-}
listOf : String -> List Argument -> SelectionSet a objectTypeLock -> FieldDecoder (List a) lockedTo
listOf fieldName args (SelectionSet fields decoder) =
    FieldDecoder (Field.Composite fieldName args fields) (Decode.list decoder |> Decode.field fieldName)


{-| Refer to single object in auto-generated code.
-}
single : String -> List Argument -> SelectionSet a objectTypeLock -> FieldDecoder a lockedTo
single fieldName args (SelectionSet fields decoder) =
    FieldDecoder (Field.Composite fieldName args fields) (decoder |> Decode.field fieldName)


{-| Used to create the `selection` functions in auto-generated code.
-}
object : (a -> constructor) -> SelectionSet (a -> constructor) typeLock
object constructor =
    SelectionSet [] (Decode.succeed constructor)
