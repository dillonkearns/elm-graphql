module GraphqElm.Argument exposing (Argument, enum, int, string, toQueryString)

import GraphqElm.TypeLock exposing (TypeLocked(TypeLocked))
import GraphqElm.Value as Value exposing (Value(..))


type Argument
    = Argument String Value


argument : String -> Value -> TypeLocked Argument lockedTo
argument fieldName value =
    Argument fieldName value
        |> TypeLocked


string : String -> String -> TypeLocked Argument lockedTo
string fieldName value =
    argument fieldName (StringValue value)


enum : String -> String -> TypeLocked Argument lockedTo
enum fieldName value =
    argument fieldName (EnumValue value)


int : String -> Int -> TypeLocked Argument lockedTo
int fieldName value =
    argument fieldName (IntValue value)


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
