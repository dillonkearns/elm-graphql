module Graphql.Generator.Interface exposing (generate)

import Dict
import Graphql.Generator.Context exposing (Context)
import Graphql.Generator.Field as FieldGenerator
import Graphql.Generator.Imports as Imports
import Graphql.Generator.ModuleName as ModuleName
import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphql.Parser.Type as Type
import ModuleName
import Result.Extra
import String.Interpolate exposing (interpolate)


generate : Context -> String -> List String -> List Type.Field -> Result String String
generate context name moduleName fields =
    fields
        |> List.map (FieldGenerator.generateForInterface context name)
        |> Result.Extra.combine
        |> Result.map2
            (\fragmentHelpers_ fields_ ->
                prepend context moduleName fields
                    ++ fragmentHelpers_
                    ++ (fields_ |> String.join "\n\n")
            )
            (fragmentHelpers context
                (context.interfaces
                    |> Dict.get name
                    |> Maybe.withDefault []
                )
                moduleName
            )


fragmentHelpers : Context -> List ClassCaseName -> List String -> Result String String
fragmentHelpers context implementors moduleName =
    [ moduleName
        |> String.join "."
        |> Ok
    , implementors
        |> List.map (aliasFieldForFragment context moduleName)
        |> Result.Extra.combine
        |> Result.map (String.join ",\n")
    , implementors
        |> List.map (exhaustiveBuildupForFragment context moduleName)
        |> Result.Extra.combine
        |> Result.map (String.join ",\n")
    , implementors
        |> List.map (maybeFragmentEntry context moduleName)
        |> Result.Extra.combine
        |> Result.map (String.join ",\n")
    ]
        |> Result.Extra.combine
        |> Result.map
            (interpolate
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
fragments selections =
    Object.exhuastiveFragmentSelection
        [
         {2}
        ]


{-| Can be used to create a non-exhuastive set of fragments by using the record
update syntax to add `SelectionSet`s for the types you want to handle.
-}
maybeFragments : Fragments (Maybe decodesTo)
maybeFragments =
    {
      {3}
    }
"""
            )


aliasFieldForFragment : Context -> List String -> ClassCaseName -> Result String String
aliasFieldForFragment context moduleName interfaceImplementor =
    Result.map2
        (\normalized object ->
            interpolate
                "on{0} : SelectionSet decodesTo {1}"
                [ normalized
                , object |> String.join "."
                ]
        )
        (ClassCaseName.normalized interfaceImplementor)
        (ModuleName.object context interfaceImplementor)


exhaustiveBuildupForFragment : Context -> List String -> ClassCaseName -> Result String String
exhaustiveBuildupForFragment context moduleName interfaceImplementor =
    ClassCaseName.normalized interfaceImplementor
        |> Result.map
            (\normalized ->
                interpolate
                    """Object.buildFragment "{1}" selections.on{0}"""
                    [ normalized
                    , ClassCaseName.raw interfaceImplementor
                    ]
            )


maybeFragmentEntry : Context -> List String -> ClassCaseName -> Result String String
maybeFragmentEntry context moduleName interfaceImplementor =
    ClassCaseName.normalized interfaceImplementor
        |> Result.map
            (\normalized ->
                interpolate
                    """on{0} = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\\_ -> Nothing)"""
                    [ normalized, ClassCaseName.raw interfaceImplementor ]
            )


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
