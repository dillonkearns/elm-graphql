module Graphql.Generator.ScopeDefinitions exposing (generate)

import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphql.Parser.Type as Type exposing (TypeDefinition(..))
import String.Interpolate exposing (interpolate)


generate : List String -> List TypeDefinition -> List ( List String, String )
generate apiSubmodule typeDefs =
    [ generateCommon "Union" unionName apiSubmodule typeDefs
    , generateCommon "Object" objectName apiSubmodule typeDefs
    , generateCommon "Interface" interfaceName apiSubmodule typeDefs
    ]


generateCommon : String -> (TypeDefinition -> Bool) -> List String -> List TypeDefinition -> ( List String, String )
generateCommon typeName includeName apiSubmodule typeDefinitions =
    (let
        typesToGenerate =
            typeDefinitions
                |> List.filter includeName
                |> List.map (\(TypeDefinition name definableType description) -> name)
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


generateType : ClassCaseName -> String
generateType name =
    interpolate
        """type {0}
    = {0}"""
        [ ClassCaseName.normalized name ]


objectName : TypeDefinition -> Bool
objectName (TypeDefinition name definableType description) =
    case definableType of
        Type.ObjectType _ _ ->
            True

        _ ->
            False


unionName : TypeDefinition -> Bool
unionName (TypeDefinition name definableType description) =
    case definableType of
        Type.UnionType _ ->
            True

        _ ->
            False


interfaceName : TypeDefinition -> Bool
interfaceName (TypeDefinition name definableType description) =
    case definableType of
        Type.InterfaceType _ _ _ ->
            True

        _ ->
            False
