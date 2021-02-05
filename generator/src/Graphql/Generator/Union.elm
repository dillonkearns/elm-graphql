module Graphql.Generator.Union exposing (generate)

import Graphql.Generator.Context exposing (Context)
import Graphql.Generator.ModuleName
import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import ModuleName
import String.Interpolate exposing (interpolate)


generate : Context -> ClassCaseName -> List String -> List ClassCaseName -> String
generate context name moduleName possibleTypes =
    prepend context moduleName
        ++ fragmentHelpers context possibleTypes moduleName


fragmentHelpers : Context -> List ClassCaseName -> List String -> String
fragmentHelpers context implementors moduleName =
    interpolate
        """
type alias Fragments decodesTo =
    {
    {1}
    }


{-| Build up a selection for this Union by passing in a Fragments record.
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
            |> List.map (exhaustiveBuildupForFragment context moduleName)
            |> String.join ",\n "
        , implementors
            |> List.map (maybeFragmentEntry context moduleName)
            |> String.join ",\n "
        ]


aliasFieldForFragment : Context -> List String -> ClassCaseName -> String
aliasFieldForFragment context moduleName interfaceImplementor =
    interpolate
        "on{0} : SelectionSet decodesTo {1}"
        [ ClassCaseName.normalized interfaceImplementor, Graphql.Generator.ModuleName.object context interfaceImplementor |> String.join "." ]


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


prepend : Context -> List String -> String
prepend context moduleName =
    interpolate """module {0} exposing (..)

import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.SelectionSet exposing (FragmentSelectionSet(..), SelectionSet(..))
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import {1}.Object
import {1}.Interface
import {1}.Union
import {1}.Scalar
import {1}.InputObject
import {1}.ScalarCodecs
import {2}
import Json.Decode as Decode
import Graphql.Internal.Encode as Encode exposing (Value)

"""
        [ moduleName |> String.join "."
        , context.apiSubmodule |> String.join "."
        , context.scalarCodecsModule
            |> Maybe.withDefault (ModuleName.fromList (context.apiSubmodule ++ [ "ScalarCodecs" ]))
            |> ModuleName.toString
        ]
