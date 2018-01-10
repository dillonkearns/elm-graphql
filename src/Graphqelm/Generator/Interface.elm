module Graphqelm.Generator.Interface exposing (generate)

import Dict
import Graphqelm.Generator.Context exposing (Context)
import Graphqelm.Generator.Field as FieldGenerator
import Graphqelm.Generator.Imports as Imports
import Graphqelm.Generator.ModuleName as ModuleName
import Graphqelm.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphqelm.Parser.Type as Type
import Interpolate exposing (interpolate)


generate : Context -> String -> List String -> List Type.Field -> String
generate context name moduleName fields =
    prepend context moduleName fields
        ++ fragments context (context.interfaces |> Dict.get name |> Maybe.withDefault []) moduleName
        ++ (List.map (FieldGenerator.generateForInterface context name) fields |> String.join "\n\n")


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
import {2}.Scalar
import Json.Decode as Decode
import Graphqelm.Internal.Encode as Encode exposing (Value)
{1}

{-| Select only common fields from the interface.
-}
commonSelection : (a -> constructor) -> SelectionSet (a -> constructor) {0}
commonSelection constructor =
    Object.selection constructor


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
