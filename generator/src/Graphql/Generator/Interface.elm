module Graphql.Generator.Interface exposing (generate)

import Dict
import Graphql.Generator.Context exposing (Context)
import Graphql.Generator.Field as FieldGenerator
import Graphql.Generator.Imports as Imports
import Graphql.Generator.ModuleName as ModuleName
import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphql.Parser.Type as Type exposing (DefinableType(..), TypeDefinition(..))
import ModuleName
import String.Interpolate exposing (interpolate)


generate : Context -> String -> List String -> List Type.Field -> String
generate context name moduleName fields =
    prepend context moduleName fields
        ++ fragmentHelpers context (context.interfaces |> Dict.get name |> Maybe.withDefault []) moduleName
        ++ (List.map (FieldGenerator.generateForInterface context name) fields |> String.join "\n\n")


fragmentHelpers : Context -> List TypeDefinition -> List String -> String
fragmentHelpers context implementors moduleName =
    interpolate
        """
type alias Fragments decodesTo =
    {
    {1}
    }


{-| Build an exhaustive selection of type-specific fragments.
-}
fragments :
      Fragments decodesTo
      -> SelectionSet decodesTo {0}
fragments selections____ =
    Object.exhaustiveFragmentSelection
        [
         {2}
        ]


{-| Can be used to create a non-exhaustive set of fragments by using the record
update syntax to add `SelectionSet`s for the types you want to handle.
-}
maybeFragments : Fragments (Maybe decodesTo)
maybeFragments =
    {
      {3}
    }
"""
        [ moduleName |> String.join "."
        , implementors
            |> List.map (aliasFieldForFragment context moduleName)
            |> String.join ",\n "
        , implementors
            |> List.map (\(Type.TypeDefinition classCaseName _ _) -> exhaustiveBuildupForFragment context moduleName classCaseName)
            |> String.join ",\n "
        , implementors
            |> List.map (\(Type.TypeDefinition classCaseName _ _) -> maybeFragmentEntry context moduleName classCaseName)
            |> String.join ",\n "
        ]


aliasFieldForFragment : Context -> List String -> TypeDefinition -> String
aliasFieldForFragment context moduleName interfaceImplementor =
    let
        importPath : Maybe ( ClassCaseName, String )
        importPath =
            case interfaceImplementor of
                TypeDefinition m (ObjectType _ _) _ ->
                    Just ( m, String.join "." <| ModuleName.object context m )

                TypeDefinition m (InterfaceType _ _ _) _ ->
                    Just ( m, String.join "." <| ModuleName.interface context m )

                _ ->
                    Nothing
    in
    Maybe.map
        (\( m, path ) ->
            interpolate
                "on{0} : SelectionSet decodesTo {1}"
                [ ClassCaseName.normalized m, path ]
        )
        importPath
        |> Maybe.withDefault ""


exhaustiveBuildupForFragment : Context -> List String -> ClassCaseName -> String
exhaustiveBuildupForFragment context moduleName interfaceImplementor =
    interpolate
        """Object.buildFragment "{1}" selections____.on{0}"""
        [ ClassCaseName.normalized interfaceImplementor, ClassCaseName.raw interfaceImplementor ]


maybeFragmentEntry : Context -> List String -> ClassCaseName -> String
maybeFragmentEntry context moduleName interfaceImplementor =
    interpolate
        """on{0} = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\\_ -> Nothing)"""
        [ ClassCaseName.normalized interfaceImplementor, ClassCaseName.raw interfaceImplementor ]


prepend : Context -> List String -> List Type.Field -> String
prepend ({ apiSubmodule } as context) moduleName fields =
    interpolate """module {0} exposing (..)

import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.SelectionSet exposing (FragmentSelectionSet(..), SelectionSet(..))
import Graphql.OptionalArgument exposing (OptionalArgument(..))
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
