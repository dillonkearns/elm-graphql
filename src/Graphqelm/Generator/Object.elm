module Graphqelm.Generator.Object exposing (generate)

import Graphqelm.Generator.Context exposing (Context)
import Graphqelm.Generator.Field as FieldGenerator
import Graphqelm.Generator.Imports as Imports
import Graphqelm.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphqelm.Parser.Type as Type
import Interpolate exposing (interpolate)


generate : Context -> ClassCaseName -> List String -> List Type.Field -> String
generate context name moduleName fields =
    prepend context moduleName fields
        ++ (List.map (FieldGenerator.generateForObject context name) fields |> String.join "\n\n")


prepend : Context -> List String -> List Type.Field -> String
prepend { apiSubmodule } moduleName fields =
    interpolate """module {0} exposing (..)

import Graphqelm.Internal.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Internal.Builder.Object as Object
import Graphqelm.SelectionSet exposing (SelectionSet)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import {2}.Object
import {2}.Interface
import {2}.Union
import {2}.Scalar
import {2}.InputObject
import Json.Decode as Decode
import Graphqelm.Internal.Encode as Encode exposing (Value)
{1}


{-| Select fields to build up a SelectionSet for this object.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) {0}
selection constructor =
    Object.selection constructor


typename__ : Field String {0}
typename__ =
    Object.fieldDecoder "__typename" [] Decode.string
"""
        [ moduleName |> String.join "."
        , Imports.importsString apiSubmodule moduleName fields
        , apiSubmodule |> String.join "."
        ]
