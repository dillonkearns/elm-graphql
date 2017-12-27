module Graphqelm.Generator.Mutation exposing (..)

import Graphqelm.Generator.Field as FieldGenerator
import Graphqelm.Generator.Imports as Imports
import Graphqelm.Generator.SpecialObjectNames exposing (SpecialObjectNames)
import Graphqelm.Parser.Type as Type exposing (Field)
import Interpolate exposing (interpolate)


generate : List String -> SpecialObjectNames -> List Field -> ( List String, String )
generate apiSubmodule specialObjectNames fields =
    ( moduleName
    , prepend apiSubmodule moduleName fields
        ++ (List.map (FieldGenerator.generate apiSubmodule specialObjectNames (specialObjectNames.mutation |> Maybe.withDefault "")) fields |> String.join "\n\n")
    )


moduleName : List String
moduleName =
    [ "Api", "Mutation" ]


prepend : List String -> List String -> List Field -> String
prepend apiSubmodule moduleName fields =
    interpolate
        """module {0} exposing (..)

import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Api.Object
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.Builder.Object as Object
import Graphqelm.SelectionSet exposing (SelectionSet)
import Graphqelm exposing (RootMutation)
import Json.Decode as Decode exposing (Decoder)
import Graphqelm.Encode as Encode exposing (Value)
{1}


selection : (a -> constructor) -> SelectionSet (a -> constructor) RootMutation
selection constructor =
    Object.object constructor
"""
        [ moduleName |> String.join ".", Imports.importsString apiSubmodule moduleName fields ]
