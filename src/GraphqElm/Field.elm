module GraphqElm.Field exposing (..)

import Json.Decode as Decode exposing (Decoder)


type Field a
    = Field String (Decoder a)



-- type FieldType a
--     = IntField
--     | StringField
-- string : String -> Field String
-- string fieldName =
--     Field fieldName StringField
-- int : String -> Field Int
-- int fieldName =
--     Field fieldName IntField


string : String -> Field String
string fieldName =
    Field fieldName Decode.string


int : String -> Field Int
int fieldName =
    Field fieldName Decode.int


with : (a -> b -> value) -> Field a -> Field b -> Field value
with mapFn ((Field fieldNameA decoderA) as fieldA) ((Field fieldNameB decoderB) as fieldB) =
    Field fieldNameA (Decode.map2 mapFn decoderA decoderB)



-- map : (a -> b) -> Field a -> Field b
-- map function (Field fieldName fieldType) =
--     Field fieldName (function fieldType)
