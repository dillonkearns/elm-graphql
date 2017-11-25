module GraphqElm.Argument exposing (Argument, int, string, toQueryString)

import GraphqElm.Value as Value exposing (Value(..))


type Argument
    = Argument String Value


argument : String -> Value -> Argument
argument fieldName value =
    Argument fieldName value


string : String -> String -> Argument
string fieldName value =
    argument fieldName (StringValue value)


int : String -> Int -> Argument
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
