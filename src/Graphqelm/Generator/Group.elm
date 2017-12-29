module Graphqelm.Generator.Group exposing (IntrospectionData, generateFiles)

import Dict exposing (Dict)
import Graphqelm.Generator.Enum
import Graphqelm.Generator.Mutation
import Graphqelm.Generator.Object
import Graphqelm.Generator.ObjectTypes as ObjectTypes
import Graphqelm.Generator.Query
import Graphqelm.Parser.Type as Type exposing (TypeDefinition)


type alias IntrospectionData =
    { typeDefinitions : List TypeDefinition
    , queryObjectName : String
    , mutationObjectName : Maybe String
    }


generateFiles : List String -> IntrospectionData -> Dict String String
generateFiles apiSubmodule { typeDefinitions, queryObjectName, mutationObjectName } =
    let
        objectTypes =
            ( apiSubmodule ++ [ "Object" ]
            , ObjectTypes.generate apiSubmodule
                (typeDefinitions
                    |> excludeBuiltIns
                    |> excludeQuery queryObjectName
                    |> excludeMutation mutationObjectName
                )
            )
    in
    typeDefinitions
        |> excludeBuiltIns
        |> List.filterMap (toPair apiSubmodule queryObjectName mutationObjectName)
        |> List.append [ objectTypes ]
        |> List.map (Tuple.mapFirst moduleToFileName)
        |> Dict.fromList


excludeBuiltIns : List TypeDefinition -> List TypeDefinition
excludeBuiltIns typeDefinitions =
    typeDefinitions
        |> List.filterMap isBuiltIn


excludeQuery : String -> List TypeDefinition -> List TypeDefinition
excludeQuery queryObjectName typeDefinitions =
    typeDefinitions
        |> List.filter (\(Type.TypeDefinition name definableType description) -> name /= queryObjectName)


excludeMutation : Maybe String -> List TypeDefinition -> List TypeDefinition
excludeMutation maybeMutationObjectName typeDefinitions =
    case maybeMutationObjectName of
        Just mutationObjectName ->
            typeDefinitions
                |> List.filter (\(Type.TypeDefinition name definableType description) -> name /= mutationObjectName)

        Nothing ->
            typeDefinitions


isBuiltIn : TypeDefinition -> Maybe TypeDefinition
isBuiltIn ((Type.TypeDefinition name definableType description) as definition) =
    if String.startsWith "__" name then
        Nothing
    else
        Just definition


moduleToFileName : List String -> String
moduleToFileName modulePath =
    (modulePath |> String.join "/")
        ++ ".elm"


toPair : List String -> String -> Maybe String -> TypeDefinition -> Maybe ( List String, String )
toPair apiSubmodule queryObjectName mutationObjectName ((Type.TypeDefinition name definableType description) as definition) =
    case definableType of
        Type.ObjectType fields ->
            if name == queryObjectName then
                Graphqelm.Generator.Query.generate apiSubmodule { query = queryObjectName, mutation = mutationObjectName } fields
                    |> Just
            else if Just name == mutationObjectName then
                Graphqelm.Generator.Mutation.generate apiSubmodule { query = queryObjectName, mutation = mutationObjectName } fields
                    |> Just
            else
                Graphqelm.Generator.Object.generate apiSubmodule { query = queryObjectName, mutation = mutationObjectName } name fields
                    |> Just

        Type.ScalarType ->
            Nothing

        Type.EnumType enumValues ->
            Graphqelm.Generator.Enum.generate apiSubmodule name enumValues
                |> Just

        Type.InterfaceType fields ->
            Graphqelm.Generator.Object.generate apiSubmodule { query = queryObjectName, mutation = mutationObjectName } name fields
                |> Just
