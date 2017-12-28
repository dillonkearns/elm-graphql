module Graphqelm.Builder.Object exposing (fieldDecoder, listOf, object, selectionFieldDecoder, single)

{-| Internal functions for use by auto-generated code from the `graphqelm` CLI.
@docs fieldDecoder, listOf, object, single, selectionFieldDecoder
-}

import Graphqelm.Builder.Argument exposing (Argument)
import Graphqelm.Field exposing (Field)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder(FieldDecoder))
import Graphqelm.SelectionSet exposing (SelectionSet(..))
import Json.Decode as Decode exposing (Decoder)


{-| Refer to a field in auto-generated code.
-}
fieldDecoder : String -> List Argument -> Decoder decodesTo -> FieldDecoder decodesTo lockedTo
fieldDecoder fieldName args decoder =
    FieldDecoder (leaf fieldName args) decoder


{-| Refer to list of objects in auto-generated code.
-}
listOf : String -> List Argument -> SelectionSet a objectTypeLock -> FieldDecoder (List a) lockedTo
listOf fieldName args (SelectionSet fields decoder) =
    FieldDecoder (composite fieldName args fields) (Decode.list decoder)


{-| Refer to single object in auto-generated code.
-}
single : String -> List Argument -> SelectionSet a objectTypeLock -> FieldDecoder a lockedTo
single fieldName args (SelectionSet fields decoder) =
    FieldDecoder (composite fieldName args fields) decoder


{-| Refer to an object in auto-generated code.
-}
selectionFieldDecoder :
    String
    -> List Argument
    -> SelectionSet a objectTypeLock
    -> (Decoder a -> Decoder b)
    -> FieldDecoder b lockedTo
selectionFieldDecoder fieldName args (SelectionSet fields decoder) decoderTransform =
    FieldDecoder (composite fieldName args fields) (decoderTransform decoder)


composite : String -> List Argument -> List Field -> Field
composite fieldName args fields =
    Graphqelm.Field.Composite fieldName args fields


leaf : String -> List Argument -> Field
leaf fieldName args =
    Graphqelm.Field.Leaf fieldName args


{-| Used to create the `selection` functions in auto-generated code.
-}
object : (a -> constructor) -> SelectionSet (a -> constructor) typeLock
object constructor =
    SelectionSet [] (Decode.succeed constructor)
