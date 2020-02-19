module Graphql.Internal.Builder.Argument exposing (Argument(..), optional, required)

{-| **WARNING** `Graphql.Internal` modules are used by the `@dillonkearns/elm-graphql` command line
code generator tool. They should not be consumed through hand-written code.

Internal functions for use by auto-generated code from the `@dillonkearns/elm-graphql` CLI.

@docs Argument, optional, required

-}

import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.OptionalArgument as OptionalArgument exposing (OptionalArgument)


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
required fieldName raw encode =
    Argument fieldName (encode raw)
