module Graphqelm.Generator.Mutation exposing (generate)

import Graphqelm.Generator.Context exposing (Context)
import Graphqelm.Generator.Field as FieldGenerator
import Graphqelm.Generator.Imports as Imports
import Graphqelm.Parser.Type as Type exposing (Field)
import Interpolate exposing (interpolate)


generate : Context -> List String -> List Field -> String
generate context moduleName fields =
    prepend context moduleName fields
        ++ (List.map (FieldGenerator.generateForObject context (context.mutation |> Maybe.withDefault "")) fields |> String.join "\n\n")


prepend : Context -> List String -> List Field -> String
prepend { apiSubmodule } moduleName fields =
    interpolate
        """module {0} exposing (..)

import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import {2}.Object
import {2}.Interface
import {2}.Union
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.Builder.Object as Object
import Graphqelm.SelectionSet exposing (SelectionSet)
import Graphqelm.Operation exposing (RootMutation)
import Json.Decode as Decode exposing (Decoder)
import Graphqelm.Encode as Encode exposing (Value)
{1}


{-| Select fields to build up a top-level mutation. The request can be sent with
functions from `Graphqelm.Http`.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) RootMutation
selection constructor =
    Object.selection constructor
"""
        [ moduleName |> String.join "."
        , Imports.importsString apiSubmodule moduleName fields
        , apiSubmodule |> String.join "."
        ]
