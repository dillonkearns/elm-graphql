module GraphqElm.Field exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)


type Field
    = Composite String (List Argument) (List Field)
    | Leaf String (List Argument)


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
