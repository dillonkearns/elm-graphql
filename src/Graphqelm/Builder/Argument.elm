module Graphqelm.Builder.Argument exposing (Argument(Argument), enum, int, optional, string)

import Graphqelm.Encode as Encode exposing (Value)


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
    argument fieldName (Encode.string value)


enum : String -> String -> Argument
enum fieldName value =
    argument fieldName (Encode.enum toString value)


int : String -> Int -> Argument
int fieldName value =
    argument fieldName (Encode.int value)
