module Graphqelm.Value exposing (Value(..), bool, enum, int, list, string)

import Json.Encode


type Value
    = EnumValue String
    | Json Json.Encode.Value
    | List (List Value)
    | String String
    | Boolean Bool
    | Integer Int


int : Int -> Value
int value =
    Integer value


bool : Bool -> Value
bool bool =
    Boolean bool


string : String -> Value
string string =
    String string


enum : (a -> String) -> a -> Value
enum enumToString enum =
    EnumValue (enumToString enum)


list : (a -> Value) -> List a -> Value
list toValue list =
    list
        |> List.map toValue
        |> List
