module Graphqelm.Field exposing (Field(..), FieldDecoder(FieldDecoder), fieldDecoder, map)

import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Json.Decode as Decode exposing (Decoder)


type FieldDecoder decodesTo typeLock
    = FieldDecoder Field (Decoder decodesTo)


type Field
    = Composite String (List Argument) (List Field)
    | Leaf String (List Argument)
    | QueryField Field


fieldDecoder : String -> List Argument -> Decoder decodesTo -> FieldDecoder decodesTo lockedTo
fieldDecoder fieldName args decoder =
    FieldDecoder (Leaf fieldName args)
        (decoder |> Decode.field fieldName)


map : (decodesTo -> mapsTo) -> FieldDecoder decodesTo typeLock -> FieldDecoder mapsTo typeLock
map mapFunction (FieldDecoder field decoder) =
    FieldDecoder field (Decode.map mapFunction decoder)
