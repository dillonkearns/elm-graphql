module Graphqelm.Generator.Group exposing (IntrospectionData, generateFiles, sortedIntrospectionData)

import Dict exposing (Dict)
import Graphqelm.Generator.Context exposing (Context)
import Graphqelm.Generator.Enum
import Graphqelm.Generator.Interface
import Graphqelm.Generator.ModuleName as ModuleName
import Graphqelm.Generator.Mutation
import Graphqelm.Generator.Object
import Graphqelm.Generator.Query
import Graphqelm.Generator.TypeLockDefinitions as TypeLockDefinitions
import Graphqelm.Parser.Type as Type exposing (TypeDefinition(TypeDefinition))


type alias IntrospectionData =
    { typeDefinitions : List TypeDefinition
    , queryObjectName : String
    , mutationObjectName : Maybe String
    }


sortedIntrospectionData : List TypeDefinition -> String -> Maybe String -> IntrospectionData
sortedIntrospectionData typeDefinitions queryObjectName mutationObjectName =
    { typeDefinitions = typeDefinitions |> List.sortBy typeDefName
    , queryObjectName = queryObjectName
    , mutationObjectName = mutationObjectName
    }


typeDefName : TypeDefinition -> String
typeDefName (TypeDefinition name definableType description) =
    name


interfacePossibleTypesDict : List TypeDefinition -> Dict String (List String)
interfacePossibleTypesDict typeDefs =
    typeDefs
        |> List.filterMap
            (\(TypeDefinition typeName definableType description) ->
                case definableType of
                    Type.InterfaceType fields possibleTypes ->
                        Just ( typeName, possibleTypes )

                    _ ->
                        Nothing
            )
        |> Dict.fromList


generateFiles : List String -> IntrospectionData -> Dict String String
generateFiles apiSubmodule { typeDefinitions, queryObjectName, mutationObjectName } =
    let
        objectTypes =
            [ TypeLockDefinitions.generateObjects apiSubmodule
                (typeDefinitions
                    |> excludeBuiltIns
                    |> excludeQuery queryObjectName
                    |> excludeMutation mutationObjectName
                )
            , TypeLockDefinitions.generateInterfaces apiSubmodule
                (typeDefinitions
                    |> excludeBuiltIns
                    |> excludeQuery queryObjectName
                    |> excludeMutation mutationObjectName
                )
            ]
    in
    typeDefinitions
        |> excludeBuiltIns
        |> List.filterMap
            (toPair
                { query = queryObjectName
                , mutation = mutationObjectName
                , apiSubmodule = apiSubmodule
                , interfaces = interfacePossibleTypesDict typeDefinitions
                }
            )
        |> List.append objectTypes
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


toPair : Context -> TypeDefinition -> Maybe ( List String, String )
toPair context ((Type.TypeDefinition name definableType description) as definition) =
    case definableType of
        Type.ObjectType fields ->
            if name == context.query then
                ( ModuleName.query context
                , Graphqelm.Generator.Query.generate context (ModuleName.query context) fields
                )
                    |> Just
            else if Just name == context.mutation then
                ( ModuleName.mutation context
                , Graphqelm.Generator.Mutation.generate context (ModuleName.mutation context) fields
                )
                    |> Just
            else
                ( ModuleName.object context name
                , Graphqelm.Generator.Object.generate context name (ModuleName.object context name) fields
                )
                    |> Just

        Type.ScalarType ->
            Nothing

        Type.EnumType enumValues ->
            ( ModuleName.enum context name
            , Graphqelm.Generator.Enum.generate name (ModuleName.enum context name) enumValues description
            )
                |> Just

        Type.InterfaceType fields possibleTypes ->
            ( ModuleName.interface context name
            , Graphqelm.Generator.Interface.generate context name (ModuleName.interface context name) fields
            )
                |> Just
