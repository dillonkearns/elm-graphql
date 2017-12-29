module Graphqelm.Builder.Argument exposing (Argument(Argument), optional, required)

{-| Internal functions for use by auto-generated code from the `graphqelm` CLI.
@docs Argument, optional, required
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


{-| Used for passing required arguments in generated code.
-}
required : String -> a -> (a -> Value) -> Argument
required fieldName value encode =
    Argument fieldName (encode value)
