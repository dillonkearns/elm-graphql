module Graphql.Generator.Interface exposing (generate)

import Dict
import Graphql.Generator.Context exposing (Context)
import Graphql.Generator.Field as FieldGenerator
import Graphql.Generator.Imports as Imports
import Graphql.Generator.ModuleName as ModuleName
import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphql.Parser.Type as Type
import String.Interpolate exposing (interpolate)


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
        """on{0} : SelectionSet decodesTo {2} -> FragmentSelectionSet decodesTo {3}
on{0} (SelectionSet fields decoder) =
    FragmentSelectionSet "{1}" fields decoder
"""
        [ ClassCaseName.normalized interfaceImplementor, ClassCaseName.raw interfaceImplementor, ModuleName.object context interfaceImplementor |> String.join ".", moduleName |> String.join "." ]


prepend : Context -> List String -> List Type.Field -> String
prepend { apiSubmodule } moduleName fields =
    interpolate """module {0} exposing (..)

import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Field as Field exposing (Field)
import Graphql.Internal.Builder.Object as Object
import Graphql.SelectionSet exposing (FragmentSelectionSet(..), SelectionSet(..))
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import {2}.Object
import {2}.Interface
import {2}.Union
import {2}.Scalar
import {2}.InputObject
import Json.Decode as Decode
import Graphql.Internal.Encode as Encode exposing (Value)
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
