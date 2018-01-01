module Graphqelm.Generator.Query exposing (..)

import Graphqelm.Generator.Field as FieldGenerator
import Graphqelm.Generator.Imports as Imports
import Graphqelm.Generator.Context exposing (Context)
import Graphqelm.Parser.Type as Type exposing (Field)
import Interpolate exposing (interpolate)


generate : List String -> Context -> List Field -> ( List String, String )
generate apiSubmodule specialObjectNames fields =
    ( moduleName apiSubmodule
    , prepend apiSubmodule (moduleName apiSubmodule) fields
        ++ (List.map (FieldGenerator.generate apiSubmodule specialObjectNames specialObjectNames.query) fields |> String.join "\n\n")
    )


moduleName : List String -> List String
moduleName apiSubmodule =
    apiSubmodule ++ [ "Query" ]


prepend : List String -> List String -> List Field -> String
prepend apiSubmodule moduleName fields =
    interpolate
        """module {0} exposing (..)

import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import {2}.Object
import Graphqelm.Builder.Object as Object
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Graphqelm exposing (RootQuery)
import Json.Decode as Decode exposing (Decoder)
import Graphqelm.Encode as Encode exposing (Value)
{1}


selection : (a -> constructor) -> SelectionSet (a -> constructor) RootQuery
selection constructor =
    Object.object constructor
"""
        [ moduleName |> String.join "."
        , Imports.importsString apiSubmodule moduleName fields
        , apiSubmodule |> String.join "."
        ]
