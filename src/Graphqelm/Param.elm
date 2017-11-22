module Graphqelm.Param exposing (Param, ParamValue, int, string)


type Param
    = Param String ParamValue


type ParamValue
    = StringValue String
    | IntValue Int


string : String -> String -> Param
string fieldName value =
    Param fieldName (StringValue value)


int : String -> Int -> Param
int fieldName value =
    Param fieldName (IntValue value)
