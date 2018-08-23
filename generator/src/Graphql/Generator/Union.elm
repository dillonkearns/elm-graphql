module Graphql.Generator.Union exposing (generate)

import Graphql.Generator.Context exposing (Context)
import Graphql.Generator.ModuleName as ModuleName
import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import String.Interpolate exposing (interpolate)


generate : Context -> ClassCaseName -> List String -> List ClassCaseName -> String
generate context name moduleName possibleTypes =
    prepend context moduleName
        ++ fragments context possibleTypes moduleName


fragments : Context -> List ClassCaseName -> List String -> String
fragments context implementors moduleName =
    implementors
        |> List.map (fragment context moduleName)
        |> String.join "\n\n"


fragment : Context -> List String -> ClassCaseName -> String
fragment context moduleName interfaceImplementor =
    interpolate
        """on{0} : SelectionSet decodesTo {2} -> FragmentSelectionSet decodesTo {3}
on{0} (SelectionSet fields decoder) =
    FragmentSelectionSet "{1}" fields decoder
"""
        [ ClassCaseName.normalized interfaceImplementor, ClassCaseName.raw interfaceImplementor, ModuleName.object context interfaceImplementor |> String.join ".", moduleName |> String.join "." ]


prepend : Context -> List String -> String
prepend { apiSubmodule } moduleName =
    interpolate """module {0} exposing (..)

import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Field as Field exposing (Field)
import Graphql.Internal.Builder.Object as Object
import Graphql.SelectionSet exposing (FragmentSelectionSet(..), SelectionSet(..))
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import {1}.Object
import {1}.Interface
import {1}.Union
import {1}.Scalar
import {1}.InputObject
import Json.Decode as Decode
import Graphql.Internal.Encode as Encode exposing (Value)


selection : (Maybe typeSpecific -> constructor) -> List (FragmentSelectionSet typeSpecific {0}) -> SelectionSet constructor {0}
selection constructor typeSpecificDecoders =
    Object.unionSelection typeSpecificDecoders constructor
"""
        [ moduleName |> String.join "."
        , apiSubmodule |> String.join "."
        ]
