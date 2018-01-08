module Swapi.InputObject.Greeting exposing (..)

import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Swapi.Enum.Language
import Swapi.InputObject.Options


encode : Greeting -> Value
encode input =
    Encode.maybeObject
        [ ( "name", Encode.string input.name |> Just )
        , ( "language", Encode.enum Swapi.Enum.Language.toString |> Encode.optional input.language )
        , ( "options", Swapi.InputObject.Options.encode |> Encode.optional input.options )
        ]


type alias Greeting =
    { name : String
    , language : OptionalArgument Swapi.Enum.Language.Language
    , options : OptionalArgument Swapi.InputObject.Options.Options
    }
