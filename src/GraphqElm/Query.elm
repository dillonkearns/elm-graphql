module GraphqElm.Query exposing (..)

import GraphqElm.Field exposing (Field, FieldDecoder(FieldDecoder), Query(Query))
import Json.Decode as Decode exposing (Decoder)


combine : (decodesToA -> decodesToB -> decodesToC) -> Query decodesToA -> Query decodesToB -> Query decodesToC
combine combineFunction (Query fieldsA decoderA) (Query fieldsB decoderB) =
    Query (fieldsA ++ fieldsB) (Decode.map2 combineFunction decoderA decoderB)


rootQuery : FieldDecoder decodesTo -> Query decodesTo
rootQuery (FieldDecoder field decoder) =
    Query [ field ] (decoder |> Decode.field "data")
