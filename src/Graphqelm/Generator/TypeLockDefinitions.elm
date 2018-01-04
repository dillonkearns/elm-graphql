module Graphqelm.Generator.TypeLockDefinitions exposing (generateInterfaces, generateObjects, generateUnions)

import Graphqelm.Parser.Type as Type exposing (TypeDefinition(TypeDefinition))
import Interpolate exposing (interpolate)


generateUnions : List String -> List TypeDefinition -> ( List String, String )
generateUnions =
    generateCommon "Union" unionName


generateObjects : List String -> List TypeDefinition -> ( List String, String )
generateObjects =
    generateCommon "Object" objectName


generateInterfaces : List String -> List TypeDefinition -> ( List String, String )
generateInterfaces =
    generateCommon "Interface" interfaceName


generateCommon : String -> (TypeDefinition -> Maybe String) -> List String -> List TypeDefinition -> ( List String, String )
generateCommon typeName nameOrNothing apiSubmodule typeDefinitions =
    (let
        typesToGenerate =
            List.filterMap nameOrNothing typeDefinitions
     in
     if typesToGenerate == [] then
        interpolate
            """module {0} exposing (..)


placeholder : String
placeholder =
    ""
"""
            [ apiSubmodule ++ [ typeName ] |> String.join "." ]
     else
        interpolate
            """module {0} exposing (..)


{1}
"""
            [ apiSubmodule ++ [ typeName ] |> String.join "."
            , typesToGenerate
                |> List.map generateType
                |> String.join "\n\n\n"
            ]
    )
        |> (\fileContents -> ( apiSubmodule ++ [ typeName ], fileContents ))


generateType : String -> String
generateType name =
    interpolate
        """type {0}
    = {0}"""
        [ name ]


objectName : TypeDefinition -> Maybe String
objectName (TypeDefinition name definableType description) =
    case definableType of
        Type.ObjectType _ ->
            Just name

        Type.InterfaceType _ _ ->
            Nothing

        Type.ScalarType ->
            Nothing

        Type.EnumType _ ->
            Nothing

        Type.UnionType _ ->
            Nothing


unionName : TypeDefinition -> Maybe String
unionName (TypeDefinition name definableType description) =
    case definableType of
        Type.ObjectType _ ->
            Nothing

        Type.InterfaceType _ _ ->
            Nothing

        Type.ScalarType ->
            Nothing

        Type.EnumType _ ->
            Nothing

        Type.UnionType _ ->
            Just name


interfaceName : TypeDefinition -> Maybe String
interfaceName (TypeDefinition name definableType description) =
    case definableType of
        Type.ObjectType _ ->
            Nothing

        Type.InterfaceType _ _ ->
            Just name

        Type.ScalarType ->
            Nothing

        Type.EnumType _ ->
            Nothing

        Type.UnionType _ ->
            Nothing
