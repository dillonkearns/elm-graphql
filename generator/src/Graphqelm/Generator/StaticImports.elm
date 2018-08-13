module Graphqelm.Generator.StaticImports exposing (all)

import Graphqelm.Generator.Context exposing (Context)
import String.Interpolate exposing (interpolate)


all : Context -> String
all { apiSubmodule } =
    interpolate
        """import Graphqelm.Internal.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Internal.Builder.Object as Object
import Graphqelm.Internal.Encode as Encode exposing (Value)
import Graphqelm.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphqelm.OptionalArgument exposing (OptionalArgument(..))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode exposing (Decoder)
import {0}.Object
import {0}.Interface
import {0}.Union
import {0}.Scalar
import {0}.InputObject
import Graphqelm.Internal.Builder.Object as Object
import Graphqelm.OptionalArgument exposing (OptionalArgument(..))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Graphqelm.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Json.Decode as Decode exposing (Decoder)
import Graphqelm.Internal.Encode as Encode exposing (Value)"""
        [ apiSubmodule |> String.join "." ]
