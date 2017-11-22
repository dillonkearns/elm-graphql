module GraphqElm.Param exposing (Param, int, string)

import GraphqElm.Value exposing (Value(..))


type Param
    = Param String Value


string : String -> String -> Param
string fieldName value =
    Param fieldName (StringValue value)


int : String -> Int -> Param
int fieldName value =
    Param fieldName (IntValue value)
