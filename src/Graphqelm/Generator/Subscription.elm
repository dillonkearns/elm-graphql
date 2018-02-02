module Graphqelm.Generator.Subscription exposing (generate)

import Graphqelm.Generator.Context exposing (Context)
import Graphqelm.Generator.Field as FieldGenerator
import Graphqelm.Generator.Imports as Imports
import Graphqelm.Parser.ClassCaseName as ClassCaseName
import Graphqelm.Parser.Type as Type exposing (Field)
import Interpolate exposing (interpolate)


generate : Context -> List String -> List Field -> String
generate context moduleName fields =
    prepend context moduleName fields
        ++ (List.map (FieldGenerator.generateForObject context (context.subscription |> Maybe.withDefault (ClassCaseName.build ""))) fields |> String.join "\n\n")


prepend : Context -> List String -> List Field -> String
prepend { apiSubmodule } moduleName fields =
    interpolate
        """module {0} exposing (..)

import Graphqelm.Internal.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field)
import {2}.Object
import {2}.Interface
import {2}.Union
import {2}.Scalar
import {2}.InputObject
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.Internal.Builder.Object as Object
import Graphqelm.SelectionSet exposing (SelectionSet)
import Graphqelm.Operation exposing (RootSubscription)
import Json.Decode as Decode exposing (Decoder)
import Graphqelm.Internal.Encode as Encode exposing (Value)
{1}


{-| Select fields to build up a top-level mutation. The request can be sent with
functions from `Graphqelm.Http`.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) RootSubscription
selection constructor =
    Object.selection constructor
"""
        [ moduleName |> String.join "."
        , Imports.importsString apiSubmodule moduleName fields
        , apiSubmodule |> String.join "."
        ]
