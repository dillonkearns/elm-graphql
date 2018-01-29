module Normalize.InputObject exposing (..)

import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Internal.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Internal.Builder.Object as Object
import Graphqelm.Internal.Encode as Encode exposing (Value)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode
import Normalize.Interface
import Normalize.Object
import Normalize.Scalar
import Normalize.Union


{-| Encode a CircularOne into a value that can be used as an argument.
-}
encodeCircularOne : CircularOne -> Value
encodeCircularOne (CircularOne input) =
    Encode.maybeObject
        [ ( "circularTwo", encodeCircularTwo |> Encode.optional input.circularTwo ) ]


{-| Type for the CircularOne input object.
-}
type CircularOne
    = CircularOne { circularTwo : OptionalArgument CircularTwo }


{-| Encode a CircularTwo into a value that can be used as an argument.
-}
encodeCircularTwo : CircularTwo -> Value
encodeCircularTwo input =
    Encode.maybeObject
        [ ( "circularOne", encodeCircularOne |> Encode.optional input.circularOne ) ]


{-| Type for the CircularTwo input object.
-}
type alias CircularTwo =
    { circularOne : OptionalArgument CircularOne }


{-| Encode a Recursive into a value that can be used as an argument.
-}
encodeRecursive : Recursive -> Value
encodeRecursive (Recursive input) =
    Encode.maybeObject
        [ ( "recursive", encodeRecursive |> Encode.optional input.recursive ) ]


{-| Type for the Recursive input object.
-}
type Recursive
    = Recursive { recursive : OptionalArgument Recursive }
