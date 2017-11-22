module GraphqElm exposing (Parameter, ParameterValue)


type Parameter
    = Parameter String ParameterValue


type ParameterValue
    = StringValue String
    | IntValue Int
