module Graphqelm.Generator.Union exposing (generate)

import Graphqelm.Generator.Context exposing (Context)
import Graphqelm.Generator.ModuleName as ModuleName
import Graphqelm.Generator.Normalize as Normalize
import Graphqelm.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Interpolate exposing (interpolate)


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
        """on{0} : SelectionSet selection {2} -> FragmentSelectionSet selection {3}
on{0} (SelectionSet fields decoder) =
    FragmentSelectionSet "{1}" fields decoder
"""
        [ ClassCaseName.normalized interfaceImplementor, ClassCaseName.raw interfaceImplementor, ModuleName.object context interfaceImplementor |> String.join ".", moduleName |> String.join "." ]


prepend : Context -> List String -> String
prepend { apiSubmodule } moduleName =
    interpolate """module {0} exposing (..)

import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object
import Graphqelm.SelectionSet exposing (FragmentSelectionSet(FragmentSelectionSet), SelectionSet(SelectionSet))
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import {1}.Object
import {1}.Interface
import {1}.Union
import Json.Decode as Decode
import Graphqelm.Encode as Encode exposing (Value)


selection : (Maybe typeSpecific -> constructor) -> List (FragmentSelectionSet typeSpecific {0}) -> SelectionSet constructor {0}
selection constructor typeSpecificDecoders =
    Object.unionSelection typeSpecificDecoders constructor
"""
        [ moduleName |> String.join "."
        , apiSubmodule |> String.join "."
        ]
