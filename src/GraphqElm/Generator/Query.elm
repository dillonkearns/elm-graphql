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

import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Api.Object
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Document exposing (RootQuery)
import Graphqelm.RootObject as RootObject
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode
import Graphqelm.Value as Value exposing (Value)
{1}


build : (a -> constructor) -> Object (a -> constructor) RootQuery
build constructor =
    RootObject.object constructor
"""
        [ moduleName |> String.join ".", Imports.importsString moduleName fields ]
