module Swapi.InputObject.Options exposing (..)

import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))


encode : Options -> Value
encode input =
    Encode.maybeObject
        [ ( "prefix", Encode.string |> Encode.optional input.prefix )
        ]


type alias Options =
    { prefix : OptionalArgument String
    }
