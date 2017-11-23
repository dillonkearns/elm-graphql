module GraphqElm.Value exposing (..)


type Value
    = StringValue String
    | IntValue Int


valueToString : Value -> String
valueToString value =
    case value of
        StringValue value ->
            toString value

        IntValue value ->
            toString value
