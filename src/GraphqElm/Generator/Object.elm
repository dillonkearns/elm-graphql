module Graphqelm.Generator.Object exposing (..)

import Graphqelm.Generator.Field as FieldGenerator
import Graphqelm.Generator.Imports as Imports
import Graphqelm.Parser.Type as Type
import Interpolate exposing (interpolate)


generate : String -> List Type.Field -> ( List String, String )
generate name fields =
    ( Imports.object name
    , prepend (Imports.object name) fields
        ++ (List.map (FieldGenerator.forObject name) fields |> String.join "\n\n")
    )


prepend : List String -> List Type.Field -> String
prepend moduleName fields =
    interpolate """module {0} exposing (..)

import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Api.Object
import Json.Decode as Decode
import Graphqelm.Encode as Encode exposing (Value)
{1}


build : (a -> constructor) -> Object (a -> constructor) {0}
build constructor =
    Object.object constructor
"""
        [ moduleName |> String.join ".", Imports.importsString moduleName fields ]
