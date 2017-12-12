module Graphqelm.Value exposing (Value, bool, enum, int, list, serialize, string)

{-|

@docs Value, bool, enum, int, list, string


## Low-Level

@docs serialize

-}

import Json.Encode


{-| Values
-}
type Value
    = EnumValue String
    | Json Json.Encode.Value
    | List (List Value)
    | String String
    | Boolean Bool
    | Integer Int


{-| Encode an int
-}
int : Int -> Value
int value =
    Integer value


{-| Encode a bool
-}
bool : Bool -> Value
bool bool =
    Boolean bool


{-| Encode a string
-}
string : String -> Value
string string =
    String string


{-| Encode an enum
-}
enum : (a -> String) -> a -> Value
enum enumToString enum =
    EnumValue (enumToString enum)


{-| Encode a list of Values
-}
list : (a -> Value) -> List a -> Value
list toValue list =
    list
        |> List.map toValue
        |> List


{-| Low-level function for serializing a `Graphqelm.Value`
-}
serialize : Value -> String
serialize value =
    case value of
        EnumValue value ->
            value

        Json json ->
            Json.Encode.encode 0 json

        List values ->
            "["
                ++ (List.map serialize values |> String.join ", ")
                ++ "]"

        String value ->
            toString value

        Boolean value ->
            toString value

        Integer value ->
            toString value
