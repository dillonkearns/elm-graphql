module GraphqElm.Value exposing (..)


type Value
    = StringValue String
    | IntValue Int
    | EnumValue String


valueToString : Value -> String
valueToString value =
    case value of
        StringValue value ->
            toString value

        -- "" ++ value ++ ""
        IntValue value ->
            toString value

        EnumValue value ->
            value
