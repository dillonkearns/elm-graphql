module Graphqelm.Generator.Union exposing (generate)

import Graphqelm.Generator.Context exposing (Context)
import Graphqelm.Generator.ModuleName as ModuleName
import Interpolate exposing (interpolate)


generate : Context -> String -> List String -> List String -> String
generate context name moduleName possibleTypes =
    prepend context moduleName
        ++ fragments context possibleTypes moduleName


fragments : Context -> List String -> List String -> String
fragments context implementors moduleName =
    implementors
        |> List.map (fragment context moduleName)
        |> String.join "\n\n"


fragment : Context -> List String -> String -> String
fragment context moduleName interfaceImplementor =
    interpolate
        """on{0} : SelectionSet selection {1} -> FragmentSelectionSet selection {2}
on{0} (SelectionSet fields decoder) =
    FragmentSelectionSet "{0}" fields decoder
"""
        [ interfaceImplementor, ModuleName.object context interfaceImplementor |> String.join ".", moduleName |> String.join "." ]


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
