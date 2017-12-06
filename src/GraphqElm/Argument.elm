module Graphqelm.Argument exposing (Argument, enum, int, string, toQueryString)

import Graphqelm.Value as Value exposing (Value(..))
import Json.Encode as Encode


type Argument
    = Argument String Value


argument : String -> Value -> Argument
argument fieldName value =
    Argument fieldName value


string : String -> String -> Argument
string fieldName value =
    argument fieldName (Json (Encode.string value))


enum : String -> String -> Argument
enum fieldName value =
    argument fieldName (EnumValue value)


int : String -> Int -> Argument
int fieldName value =
    argument fieldName (Json (Encode.int value))


toQueryString : List Argument -> String
toQueryString args =
    case args of
        [] ->
            ""

        nonemptyArgs ->
            "("
                ++ (nonemptyArgs
                        |> List.map argToString
                        |> String.join ", "
                   )
                ++ ")"


argToString : Argument -> String
argToString (Argument name value) =
    name ++ ": " ++ Value.valueToString value
