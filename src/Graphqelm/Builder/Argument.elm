module Graphqelm.Builder.Argument exposing (Argument, enum, int, optional, string, toQueryString)

import Graphqelm.Value as Value exposing (Value)
import Json.Encode


type Argument
    = Argument String Value


optional : String -> Maybe a -> (a -> Value) -> Maybe Argument
optional fieldName maybeValue toValue =
    maybeValue
        |> Maybe.map (\value -> Argument fieldName (toValue value))


argument : String -> Value -> Argument
argument fieldName value =
    Argument fieldName value


string : String -> String -> Argument
string fieldName value =
    argument fieldName (Value.Json (Json.Encode.string value))


enum : String -> String -> Argument
enum fieldName value =
    argument fieldName (Value.EnumValue value)


int : String -> Int -> Argument
int fieldName value =
    argument fieldName (Value.Json (Json.Encode.int value))



-- TODO EXTRACT: query generator


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



-- TODO EXTRACT: query generator


argToString : Argument -> String
argToString (Argument name value) =
    name ++ ": " ++ Value.valueToString value
