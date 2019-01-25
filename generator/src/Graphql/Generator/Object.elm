module Graphql.Generator.Object exposing (generate)

import Graphql.Generator.Context exposing (Context)
import Graphql.Generator.Field as FieldGenerator
import Graphql.Generator.Imports as Imports
import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphql.Parser.Type as Type
import ModuleName
import String.Interpolate exposing (interpolate)


generate : Context -> ClassCaseName -> List String -> List Type.Field -> String
generate context name moduleName fields =
    prepend context moduleName fields
        ++ (List.map (FieldGenerator.generateForObject context name) fields |> String.join "\n\n")


prepend : Context -> List String -> List Type.Field -> String
prepend ({ apiSubmodule } as context) moduleName fields =
    interpolate """module {0} exposing (..)

import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.SelectionSet exposing (SelectionSet)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import {2}.Object
import {2}.Interface
import {2}.Union
import {2}.Scalar
import {2}.InputObject
import {3}
import Json.Decode as Decode
import Graphql.Internal.Encode as Encode exposing (Value)
{1}
"""
        [ moduleName |> String.join "."
        , Imports.importsString apiSubmodule moduleName fields
        , apiSubmodule |> String.join "."
        , context.scalarCodecsModule
            |> Maybe.withDefault (ModuleName.fromList (context.apiSubmodule ++ [ "ScalarCodecs" ]))
            |> ModuleName.toString
        ]
