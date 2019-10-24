module Graphql.Generator.TypeLockDefinitions exposing (generate)

import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphql.Parser.Type as Type exposing (TypeDefinition(..))
import Result.Extra
import String.Interpolate exposing (interpolate)


generate : List String -> List TypeDefinition -> Result String (List ( List String, String ))
generate apiSubmodule typeDefs =
    [ generateCommon "Union" unionName apiSubmodule typeDefs
    , generateCommon "Object" objectName apiSubmodule typeDefs
    , generateCommon "Interface" interfaceName apiSubmodule typeDefs
    ]
        |> Result.Extra.combine


generateCommon : String -> (TypeDefinition -> Bool) -> List String -> List TypeDefinition -> Result String ( List String, String )
generateCommon typeName includeName apiSubmodule typeDefinitions =
    typeDefinitions
        |> List.filter includeName
        |> List.map (\(TypeDefinition name definableType description) -> name)
        |> List.map generateType
        |> Result.Extra.combine
        |> Result.map
            (\results ->
                if results == [] then
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
                        , results
                            |> String.join "\n\n\n"
                        ]
            )
        |> Result.map
            (\fileContents ->
                ( apiSubmodule ++ [ typeName ], fileContents )
            )


generateType : ClassCaseName -> Result String String
generateType =
    ClassCaseName.normalized
        >> Result.map
            (\res ->
                interpolate
                    """type {0}
    = {0}"""
                    [ res ]
            )


objectName : TypeDefinition -> Bool
objectName (TypeDefinition name definableType description) =
    case definableType of
        Type.ObjectType _ ->
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
        Type.InterfaceType _ _ ->
            True

        _ ->
            False
