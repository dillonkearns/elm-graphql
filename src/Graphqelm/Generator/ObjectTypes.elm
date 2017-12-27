module Graphqelm.Generator.ObjectTypes exposing (generate)

import Graphqelm.Parser.Type as Type exposing (TypeDefinition(TypeDefinition))
import Interpolate exposing (interpolate)


generate : List String -> List TypeDefinition -> String
generate apiSubmodule typeDefinitions =
    let
        typesToGenerate =
            List.filterMap nameIfDefinitionNeeded typeDefinitions
    in
    if typesToGenerate == [] then
        interpolate
            """module {0}.Object exposing (..)


placeholder : String
placeholder =
    ""
"""
            [ apiSubmodule |> String.join "." ]
    else
        interpolate
            """module {0}.Object exposing (..)


{1}
"""
            [ apiSubmodule |> String.join "."
            , typesToGenerate
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

        Type.ScalarType ->
            Nothing

        Type.EnumType _ ->
            Nothing
