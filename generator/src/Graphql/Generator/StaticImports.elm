module Graphql.Generator.StaticImports exposing (all)

import Graphql.Generator.Context exposing (Context)
import ModuleName
import String.Interpolate exposing (interpolate)


all : Context -> String
all ({ apiSubmodule } as context) =
    interpolate
        """import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode exposing (Decoder)
import {0}.Object
import {0}.Interface
import {0}.Union
import {0}.Scalar
import {0}.InputObject
import {1}
import Graphql.Internal.Builder.Object as Object
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Json.Decode as Decode exposing (Decoder)
import Graphql.Internal.Encode as Encode exposing (Value)"""
        [ apiSubmodule |> String.join "."
        , context.scalarCodecsModule
            |> Maybe.withDefault (ModuleName.fromList (context.apiSubmodule ++ [ "ScalarCodecs" ]))
            |> ModuleName.toString
        ]
