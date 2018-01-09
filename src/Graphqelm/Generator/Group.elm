module Graphqelm.Generator.Group exposing (IntrospectionData, generateFiles, sortedIntrospectionData)

import Dict exposing (Dict)
import Graphqelm.Generator.Context exposing (Context)
import Graphqelm.Generator.Enum
import Graphqelm.Generator.InputObject
import Graphqelm.Generator.Interface
import Graphqelm.Generator.ModuleName as ModuleName
import Graphqelm.Generator.Mutation
import Graphqelm.Generator.Object
import Graphqelm.Generator.Query
import Graphqelm.Generator.TypeLockDefinitions as TypeLockDefinitions
import Graphqelm.Generator.Union
import Graphqelm.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
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
    ClassCaseName.normalized name


interfacePossibleTypesDict : List TypeDefinition -> Dict String (List ClassCaseName)
interfacePossibleTypesDict typeDefs =
    typeDefs
        |> List.filterMap
            (\(TypeDefinition typeName definableType description) ->
                case definableType of
                    Type.InterfaceType fields possibleTypes ->
                        Just ( ClassCaseName.raw typeName, possibleTypes )

                    _ ->
                        Nothing
            )
        |> Dict.fromList


generateFiles : List String -> IntrospectionData -> Dict String String
generateFiles apiSubmodule { typeDefinitions, queryObjectName, mutationObjectName } =
    let
        context : Context
        context =
            { query = ClassCaseName.build queryObjectName
            , mutation = mutationObjectName |> Maybe.map ClassCaseName.build
            , apiSubmodule = apiSubmodule
            , interfaces = interfacePossibleTypesDict typeDefinitions
            }

        typeLockDefinitions =
            TypeLockDefinitions.generate apiSubmodule
                (typeDefinitions
                    |> excludeBuiltIns
                    |> excludeQuery context
                    |> excludeMutation context
                )
    in
    typeDefinitions
        |> excludeBuiltIns
        |> List.filterMap (toPair context)
        |> List.append typeLockDefinitions
        |> List.map (Tuple.mapFirst moduleToFileName)
        |> Dict.fromList


excludeBuiltIns : List TypeDefinition -> List TypeDefinition
excludeBuiltIns typeDefinitions =
    typeDefinitions
        |> List.filter
            (\(Type.TypeDefinition name definableType description) ->
                not (ClassCaseName.isBuiltIn name)
            )


excludeQuery : Context -> List TypeDefinition -> List TypeDefinition
excludeQuery { query } typeDefinitions =
    typeDefinitions
        |> List.filter (\(Type.TypeDefinition name definableType description) -> name /= query)


excludeMutation : Context -> List TypeDefinition -> List TypeDefinition
excludeMutation { mutation } typeDefinitions =
    case mutation of
        Just mutationObjectName ->
            typeDefinitions
                |> List.filter (\(Type.TypeDefinition name definableType description) -> name /= mutationObjectName)

        Nothing ->
            typeDefinitions


moduleToFileName : List String -> String
moduleToFileName modulePath =
    (modulePath |> String.join "/")
        ++ ".elm"


toPair : Context -> TypeDefinition -> Maybe ( List String, String )
toPair context ((Type.TypeDefinition name definableType description) as definition) =
    let
        moduleName =
            ModuleName.generate context definition
    in
    (case definableType of
        Type.ObjectType fields ->
            if name == context.query then
                Graphqelm.Generator.Query.generate context moduleName fields
                    |> Just
            else if Just name == context.mutation then
                Graphqelm.Generator.Mutation.generate context moduleName fields
                    |> Just
            else
                Graphqelm.Generator.Object.generate context name moduleName fields
                    |> Just

        Type.ScalarType ->
            Nothing

        Type.EnumType enumValues ->
            Graphqelm.Generator.Enum.generate name moduleName enumValues description
                |> Just

        Type.InterfaceType fields possibleTypes ->
            Graphqelm.Generator.Interface.generate context (ClassCaseName.raw name) moduleName fields
                |> Just

        Type.UnionType possibleTypes ->
            Graphqelm.Generator.Union.generate context name moduleName possibleTypes
                |> Just

        Type.InputObjectType fields ->
            Graphqelm.Generator.InputObject.generate context name moduleName fields
                |> Just
    )
        |> Maybe.map (\fileContents -> ( moduleName, fileContents ))
