module Graphqelm.Generator.Mutation exposing (..)

import Graphqelm.Generator.Field as FieldGenerator
import Graphqelm.Generator.Imports as Imports
import Graphqelm.Parser.Type as Type exposing (Field)
import Interpolate exposing (interpolate)


generate : List Field -> ( List String, String )
generate fields =
    ( moduleName
    , prepend moduleName fields
        ++ (List.map FieldGenerator.forMutation fields |> String.join "\n\n")
    )


moduleName : List String
moduleName =
    [ "Api", "Mutation" ]


prepend : List String -> List Field -> String
prepend moduleName fields =
    interpolate
        """module {0} exposing (..)

import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Api.Object
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.RootObject as RootObject
import Graphqelm exposing (RootMutation)
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode
import Graphqelm.Value as Value exposing (Value)
{1}


build : (a -> constructor) -> Object (a -> constructor) RootMutation
build constructor =
    RootObject.object constructor
"""
        [ moduleName |> String.join ".", Imports.importsString moduleName fields ]
