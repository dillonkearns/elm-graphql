module GraphqElm.Field exposing (..)

import Json.Decode as Decode exposing (Decoder)


type Field
    = Composite String (List Argument) (List Field)
    | Leaf String (List Argument)


type Argument
    = StringArgument String
    | IntArgument Int


type Selection a
    = Selection (List String) (Decoder a)


toQuery : Field -> String
toQuery field =
    ""


selection : (value -> record) -> Selection (value -> record)
selection constructor =
    Selection [] (Decode.succeed constructor)


string : String -> Field
string fieldName =
    Leaf fieldName []


int : String -> Field
int fieldName =
    Leaf fieldName []



-- with : (a -> b -> value) -> Field a -> Selection b -> Selection value
-- with mapFn (Field fieldName fieldDecoder) (Selection selectionFieldNames selectionDecoder) =
--     Selection (fieldName :: selectionFieldNames) (Decode.map2 mapFn fieldDecoder selectionDecoder)
-- map : (a -> b) -> Field a -> Field b
-- map function (Field fieldName fieldType) =
--     Field fieldName (function fieldType)
