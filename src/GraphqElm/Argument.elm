module Graphqelm.Argument exposing (Argument, enum, int, optional, string, toQueryString)

import Graphqelm.Value as Value exposing (Value)
import Json.Encode


type Argument
    = Argument String Value


optional : String -> Maybe a -> (a -> Json.Encode.Value) -> Maybe Argument
optional fieldName maybeValue encoder =
    maybeValue
        |> Maybe.map (\value -> Argument fieldName (Value.Json (encoder value)))


argument : String -> Value -> Argument
argument fieldName value =
    Argument fieldName value


json : String -> Json.Encode.Value -> Argument
json fieldName value =
    argument fieldName (Value.Json value)


string : String -> String -> Argument
string fieldName value =
    argument fieldName (Value.Json (Json.Encode.string value))


enum : String -> String -> Argument
enum fieldName value =
    argument fieldName (Value.EnumValue value)


int : String -> Int -> Argument
int fieldName value =
    argument fieldName (Value.Json (Json.Encode.int value))


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
