module Graphqelm.Query exposing (..)

import Graphqelm.Field exposing (Field, FieldDecoder(FieldDecoder), Query(Query))
import Json.Decode as Decode exposing (Decoder)


combine : (decodesToA -> decodesToB -> decodesToC) -> Query decodesToA -> Query decodesToB -> Query decodesToC
combine combineFunction (Query fieldsA decoderA) (Query fieldsB decoderB) =
    Query (fieldsA ++ fieldsB) (Decode.map2 combineFunction decoderA decoderB)


rootQuery : FieldDecoder decodesTo lockedTo -> Query decodesTo
rootQuery (FieldDecoder field decoder) =
    Query [ field ] (decoder |> Decode.field "data")
