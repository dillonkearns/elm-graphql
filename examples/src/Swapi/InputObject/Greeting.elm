module Swapi.InputObject.Greeting exposing (..)

import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Swapi.Enum.Language
import Swapi.InputObject.Options


encode : Greeting -> Value
encode input =
    Encode.maybeObject
        [ ( "name", Just (Encode.string input.name) )
        , ( "language", Encode.optional (Encode.enum Swapi.Enum.Language.toString) input.language )
        , ( "options", Encode.optional Swapi.InputObject.Options.encode input.options )
        ]


type alias Greeting =
    { name : String
    , language : OptionalArgument Swapi.Enum.Language.Language
    , options : OptionalArgument Swapi.InputObject.Options.Options
    }
