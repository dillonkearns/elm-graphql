module Graphqelm.Generator.Query exposing (..)

import Graphqelm.Generator.Field as FieldGenerator
import Graphqelm.Generator.Imports as Imports
import Graphqelm.Parser.Type as Type exposing (Field)
import Interpolate exposing (interpolate)


generate : List Field -> ( List String, String )
generate fields =
    ( moduleName
    , prepend moduleName fields
        ++ (List.map FieldGenerator.forQuery fields |> String.join "\n\n")
    )


moduleName : List String
moduleName =
    [ "Api", "Query" ]


prepend : List String -> List Field -> String
prepend moduleName fields =
    interpolate
        """module {0} exposing (..)

import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Api.Object
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm exposing (RootQuery)
import Graphqelm.Builder.RootObject as RootObject
import Json.Decode as Decode exposing (Decoder)
import Graphqelm.Encode as Encode exposing (Value)
{1}


build : (a -> constructor) -> Object (a -> constructor) RootQuery
build constructor =
    RootObject.object constructor
"""
        [ moduleName |> String.join ".", Imports.importsString moduleName fields ]
