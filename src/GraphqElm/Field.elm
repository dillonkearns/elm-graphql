module GraphqElm.Field exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import Json.Decode as Decode exposing (Decoder)


type Field
    = Composite String (List Argument) (List Field)
    | Leaf String (List Argument)


type Selection a
    = Selection (List String) (Decoder a)


toQuery : Field -> String
toQuery field =
    "{\n"
        ++ (case field of
                Composite fieldName args children ->
                    fieldName
                        ++ Argument.toQueryString args
                        ++ " "
                        ++ (children
                                |> List.map toQuery
                                |> String.join "\n"
                           )

                Leaf fieldName args ->
                    fieldName
           )
        ++ "\n}"


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
