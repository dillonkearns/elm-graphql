module Graphqelm.Generator.ObjectTypes exposing (generate)

import Graphqelm.Parser.Type as Type exposing (TypeDefinition(TypeDefinition))
import Interpolate exposing (interpolate)


generate : List TypeDefinition -> String
generate typeDefinitions =
    let
        typesToGenerate =
            List.filterMap nameIfDefinitionNeeded typeDefinitions
    in
    if typesToGenerate == [] then
        """module Api.Object exposing (..)


placeholder : String
placeholder =
    ""
"""
    else
        interpolate
            """module Api.Object exposing (..)


{0}
"""
            [ typesToGenerate
                |> List.map generateType
                |> String.join "\n\n\n"
            ]


generateType : String -> String
generateType name =
    interpolate
        """type {0}
    = {0}"""
        [ name ]


nameIfDefinitionNeeded : TypeDefinition -> Maybe String
nameIfDefinitionNeeded (TypeDefinition name definableType) =
    case definableType of
        Type.ObjectType _ ->
            Just name

        Type.InterfaceType _ ->
            Just name

        _ ->
            Nothing
