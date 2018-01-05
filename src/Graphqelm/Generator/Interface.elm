module Graphqelm.Generator.Interface exposing (generate)

import Dict
import Graphqelm.Generator.Context exposing (Context)
import Graphqelm.Generator.Field as FieldGenerator
import Graphqelm.Generator.Imports as Imports
import Graphqelm.Generator.ModuleName as ModuleName
import Graphqelm.Parser.Type as Type
import Interpolate exposing (interpolate)


generate : Context -> String -> List String -> List Type.Field -> String
generate context name moduleName fields =
    prepend context moduleName fields
        ++ fragments context (context.interfaces |> Dict.get name |> Maybe.withDefault []) moduleName
        ++ (List.map (FieldGenerator.generateForInterface context name) fields |> String.join "\n\n")


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


prepend : Context -> List String -> List Type.Field -> String
prepend { apiSubmodule } moduleName fields =
    interpolate """module {0} exposing (..)

import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object
import Graphqelm.SelectionSet exposing (FragmentSelectionSet(FragmentSelectionSet), SelectionSet(SelectionSet))
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import {2}.Object
import {2}.Interface
import {2}.Union
import Json.Decode as Decode
import Graphqelm.Encode as Encode exposing (Value)
{1}

{-| Select only common fields from the interface.
-}
commonSelection : (a -> constructor) -> SelectionSet (a -> constructor) {0}
commonSelection constructor =
    Object.object constructor


{-| Select both common and type-specific fields from the interface.
-}
selection : (Maybe typeSpecific -> a -> constructor) -> List (FragmentSelectionSet typeSpecific {0}) -> SelectionSet (a -> constructor) {0}
selection constructor typeSpecificDecoders =
    Object.interfaceSelection typeSpecificDecoders constructor
"""
        [ moduleName |> String.join "."
        , Imports.importsString apiSubmodule moduleName fields
        , apiSubmodule |> String.join "."
        ]
