module Graphqelm.FieldDecoder exposing (FieldDecoder(FieldDecoder), map)

import Graphqelm.Field as Field exposing (Field)
import Json.Decode as Decode exposing (Decoder)


type FieldDecoder decodesTo typeLock
    = FieldDecoder Field (Decoder decodesTo)


map : (decodesTo -> mapsTo) -> FieldDecoder decodesTo typeLock -> FieldDecoder mapsTo typeLock
map mapFunction (FieldDecoder field decoder) =
    FieldDecoder field (Decode.map mapFunction decoder)
