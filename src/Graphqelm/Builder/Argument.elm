module Graphqelm.Builder.Argument exposing (Argument(Argument), optional, string)

{-| Internal functions for use by auto-generated code from the `graphqelm` CLI.
@docs Argument, optional, string
-}

import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.OptionalArgument as OptionalArgument exposing (OptionalArgument)


{-| Argument type.
-}
type Argument
    = Argument String Value


{-| Used for passing optional arguments in generated code.
-}
optional : String -> OptionalArgument a -> (a -> Value) -> Maybe Argument
optional fieldName maybeValue toValue =
    case maybeValue of
        OptionalArgument.Present value ->
            Argument fieldName (toValue value)
                |> Just

        OptionalArgument.Absent ->
            Nothing

        OptionalArgument.Null ->
            Argument fieldName Encode.null
                |> Just


argument : String -> Value -> Argument
argument fieldName value =
    Argument fieldName value


{-| String argument.
-}
string : String -> String -> Argument
string fieldName value =
    argument fieldName (Encode.string value)
