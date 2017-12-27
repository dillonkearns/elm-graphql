module Graphqelm.Generator.Object exposing (..)

import Graphqelm.Generator.Field as FieldGenerator
import Graphqelm.Generator.Imports as Imports
import Graphqelm.Generator.SpecialObjectNames exposing (SpecialObjectNames)
import Graphqelm.Parser.Type as Type
import Interpolate exposing (interpolate)


generate : SpecialObjectNames -> String -> List Type.Field -> ( List String, String )
generate specialObjectNames name fields =
    ( Imports.object specialObjectNames name
    , prepend (Imports.object specialObjectNames name) fields
        ++ (List.map (FieldGenerator.generate specialObjectNames name) fields |> String.join "\n\n")
    )


prepend : List String -> List Type.Field -> String
prepend moduleName fields =
    interpolate """module {0} exposing (..)

import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object
import Graphqelm.SelectionSet exposing (SelectionSet)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Api.Object
import Json.Decode as Decode
import Graphqelm.Encode as Encode exposing (Value)
{1}


selection : (a -> constructor) -> SelectionSet (a -> constructor) {0}
selection constructor =
    Object.object constructor
"""
        [ moduleName |> String.join ".", Imports.importsString moduleName fields ]
