module Graphqelm.Generator.Object exposing (..)

import Graphqelm.Generator.Field as FieldGenerator
import Graphqelm.Generator.Imports as Imports
import Graphqelm.Parser.Type as Type exposing (Field, TypeDefinition, TypeReference)
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

import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Api.Object
import Json.Decode as Decode
import Json.Encode as Encode
import Graphqelm.Value as Value
{1}


build : (a -> constructor) -> Object (a -> constructor) {0}
build constructor =
    Object.object constructor
"""
        [ moduleName |> String.join ".", Imports.importsString moduleName fields ]
