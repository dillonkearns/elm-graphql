module Graphqelm.Generator.Object exposing (generate)

import Graphqelm.Generator.Context exposing (Context)
import Graphqelm.Generator.Field as FieldGenerator
import Graphqelm.Generator.Imports as Imports
import Graphqelm.Parser.Type as Type
import Interpolate exposing (interpolate)


generate : Context -> String -> List Type.Field -> ( List String, String )
generate context name fields =
    ( Imports.object context name
    , prepend context (Imports.object context name) fields
        ++ (List.map (FieldGenerator.generateForObject context name) fields |> String.join "\n\n")
    )


prepend : Context -> List String -> List Type.Field -> String
prepend { apiSubmodule } moduleName fields =
    interpolate """module {0} exposing (..)

import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object
import Graphqelm.SelectionSet exposing (SelectionSet)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import {2}.Object
import {2}.Interface
import Json.Decode as Decode
import Graphqelm.Encode as Encode exposing (Value)
{1}


selection : (a -> constructor) -> SelectionSet (a -> constructor) {0}
selection constructor =
    Object.object constructor
"""
        [ moduleName |> String.join "."
        , Imports.importsString apiSubmodule moduleName fields
        , apiSubmodule |> String.join "."
        ]
