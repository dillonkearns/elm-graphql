module Graphql.Generator.Group exposing (IntrospectionData, generateFiles, interfaceImplementorsDict, sortedIntrospectionData)

import Dict exposing (Dict)
import Graphql.Generator.Context exposing (Context)
import Graphql.Generator.Enum
import Graphql.Generator.InputObjectFile
import Graphql.Generator.Interface
import Graphql.Generator.ModuleName as ModuleName
import Graphql.Generator.Mutation
import Graphql.Generator.Object
import Graphql.Generator.Query
import Graphql.Generator.Scalar as Scalar
import Graphql.Generator.ScalarCodecs as ScalarCodecs
import Graphql.Generator.ScopeDefinitions as ScopeDefinitions
import Graphql.Generator.Subscription
import Graphql.Generator.Union
import Graphql.Generator.VerifyScalarCodecs
import Graphql.Parser.ClassCaseName as ClassCaseName
import Graphql.Parser.Type as Type exposing (TypeDefinition(..))
import ModuleName exposing (ModuleName)


type alias IntrospectionData =
    { typeDefinitions : List TypeDefinition
    , queryObjectName : String
    , mutationObjectName : Maybe String
    , subscriptionObjectName : Maybe String
    }


sortedIntrospectionData : List TypeDefinition -> String -> Maybe String -> Maybe String -> IntrospectionData
sortedIntrospectionData typeDefinitions queryObjectName mutationObjectName subscriptionObjectName =
    { typeDefinitions = typeDefinitions |> List.sortBy typeDefName
    , queryObjectName = queryObjectName
    , mutationObjectName = mutationObjectName
    , subscriptionObjectName = subscriptionObjectName
    }


typeDefName : TypeDefinition -> String
typeDefName (TypeDefinition name _ _) =
    ClassCaseName.normalized name


interfaceImplementorsDict : List TypeDefinition -> Dict String (List TypeDefinition)
interfaceImplementorsDict typeDefs =
    let
        ( interfaceTypes, objectTypes ) =
            Tuple.pair typeDefs typeDefs
                |> Tuple.mapBoth (List.filter Type.isInterfaceType) (List.filter Type.isObjectType)

        interfaceImplementations : String -> List TypeDefinition -> List TypeDefinition
        interfaceImplementations interfaceName objectsAndInterfaces =
            -- Filter list based on Interfaces or Objects that implement the passed in Interface name
            List.filter
                (\objectOrInterface ->
                    Type.interfacesImplemented objectOrInterface
                        |> List.map ClassCaseName.raw
                        |> List.any ((==) interfaceName)
                )
                objectsAndInterfaces

        interfaceToPossibleTypes : List ( String, List TypeDefinition )
        interfaceToPossibleTypes =
            List.map
                (\interface ->
                    ( Type.rawName interface, interfaceImplementations (Type.rawName interface) (List.append interfaceTypes objectTypes) )
                )
                interfaceTypes
    in
    interfaceToPossibleTypes
        |> Dict.fromList


generateFiles : { apiSubmodule : List String, scalarCodecsModule : Maybe ModuleName } -> IntrospectionData -> Dict String String
generateFiles options { typeDefinitions, queryObjectName, mutationObjectName, subscriptionObjectName } =
    let
        context : Context
        context =
            { query = ClassCaseName.build queryObjectName
            , mutation = mutationObjectName |> Maybe.map ClassCaseName.build
            , subscription = subscriptionObjectName |> Maybe.map ClassCaseName.build
            , apiSubmodule = options.apiSubmodule
            , interfaces = interfaceImplementorsDict typeDefinitions
            , scalarCodecsModule = options.scalarCodecsModule
            }

        definitionsWithExclusions =
            typeDefinitions
                |> excludeBuiltIns
                |> excludeQuery context
                |> excludeMutation context
                |> excludeSubscription context

        scopeDefinitions =
            ScopeDefinitions.generate options.apiSubmodule definitionsWithExclusions

        scalarDefinitions =
            Scalar.generate options.apiSubmodule definitionsWithExclusions
    in
    typeDefinitions
        |> excludeBuiltIns
        |> List.filterMap (toPair context)
        |> List.append scopeDefinitions
        |> List.append [ Graphql.Generator.InputObjectFile.generate context typeDefinitions ]
        |> List.append [ scalarDefinitions ]
        |> List.append
            [ ScalarCodecs.generate context definitionsWithExclusions ]
        |> List.append
            [ Graphql.Generator.VerifyScalarCodecs.generate context definitionsWithExclusions ]
        |> List.map (Tuple.mapFirst moduleToFileName)
        |> Dict.fromList


excludeBuiltIns : List TypeDefinition -> List TypeDefinition
excludeBuiltIns typeDefinitions =
    typeDefinitions
        |> List.filter
            (\(TypeDefinition name _ _) ->
                not (ClassCaseName.isBuiltIn name)
            )


excludeQuery : Context -> List TypeDefinition -> List TypeDefinition
excludeQuery { query } typeDefinitions =
    typeDefinitions
        |> List.filter (\(TypeDefinition name _ _) -> name /= query)


excludeMutation : Context -> List TypeDefinition -> List TypeDefinition
excludeMutation { mutation } typeDefinitions =
    case mutation of
        Just mutationObjectName ->
            typeDefinitions
                |> List.filter (\(TypeDefinition name _ _) -> name /= mutationObjectName)

        Nothing ->
            typeDefinitions


excludeSubscription : Context -> List TypeDefinition -> List TypeDefinition
excludeSubscription { subscription } typeDefinitions =
    case subscription of
        Just subscriptionObjectName ->
            typeDefinitions
                |> List.filter (\(TypeDefinition name _ _) -> name /= subscriptionObjectName)

        Nothing ->
            typeDefinitions


moduleToFileName : List String -> String
moduleToFileName modulePath =
    (modulePath |> String.join "/")
        ++ ".elm"


toPair : Context -> TypeDefinition -> Maybe ( List String, String )
toPair context ((TypeDefinition name definableType description) as definition) =
    let
        moduleName =
            ModuleName.generate context definition
    in
    (case definableType of
        Type.ObjectType fields _ ->
            if name == context.query then
                Graphql.Generator.Query.generate context moduleName fields
                    |> Just

            else if Just name == context.mutation then
                Graphql.Generator.Mutation.generate context moduleName fields
                    |> Just

            else if Just name == context.subscription then
                Graphql.Generator.Subscription.generate context moduleName fields
                    |> Just

            else
                Graphql.Generator.Object.generate context name moduleName fields
                    |> Just

        Type.ScalarType ->
            Nothing

        Type.EnumType enumValues ->
            Graphql.Generator.Enum.generate name moduleName enumValues description
                |> Just

        Type.InterfaceType fields _ _ ->
            Graphql.Generator.Interface.generate context (ClassCaseName.raw name) moduleName fields
                |> Just

        Type.UnionType possibleTypes ->
            Graphql.Generator.Union.generate context name moduleName possibleTypes
                |> Just

        Type.InputObjectType _ ->
            Nothing
    )
        |> Maybe.map (\fileContents -> ( moduleName, fileContents ))
