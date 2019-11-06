module Graphql.Generator.Group exposing (IntrospectionData, generateFiles, sortedIntrospectionData)

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
import Graphql.Generator.Subscription
import Graphql.Generator.TypeLockDefinitions as TypeLockDefinitions
import Graphql.Generator.Union
import Graphql.Generator.VerifyScalarCodecs
import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
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
    { typeDefinitions =
        typeDefinitions
            |> List.sortBy
                (typeDefName
                    >> Result.withDefault ""
                )
    , queryObjectName = queryObjectName
    , mutationObjectName = mutationObjectName
    , subscriptionObjectName = subscriptionObjectName
    }


typeDefName : TypeDefinition -> Result String String
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


generateFiles : { apiSubmodule : List String, scalarCodecsModule : Maybe ModuleName } -> IntrospectionData -> Result String (Dict String String)
generateFiles options { typeDefinitions, queryObjectName, mutationObjectName, subscriptionObjectName } =
    let
        context : Context
        context =
            { query = ClassCaseName.build queryObjectName
            , mutation = mutationObjectName |> Maybe.map ClassCaseName.build
            , subscription = subscriptionObjectName |> Maybe.map ClassCaseName.build
            , apiSubmodule = options.apiSubmodule
            , interfaces = interfacePossibleTypesDict typeDefinitions
            , scalarCodecsModule = options.scalarCodecsModule
            }

        definitionsWithExclusions =
            typeDefinitions
                |> excludeBuiltIns
                |> excludeQuery context
                |> excludeMutation context
                |> excludeSubscription context
    in
    Result.map5
        (\typeLockDefinitions verified scalarCodecs scalarDefinitions inputObjectFile ->
            typeDefinitions
                |> excludeBuiltIns
                |> List.filterMap (toPair context)
                |> List.append typeLockDefinitions
                |> List.append [ inputObjectFile ]
                |> List.append [ scalarDefinitions ]
                |> List.append
                    [ scalarCodecs ]
                |> List.append
                    [ verified ]
                |> List.map (Tuple.mapFirst moduleToFileName)
                |> Dict.fromList
        )
        (TypeLockDefinitions.generate options.apiSubmodule definitionsWithExclusions)
        (Graphql.Generator.VerifyScalarCodecs.generate context definitionsWithExclusions)
        (ScalarCodecs.generate context definitionsWithExclusions)
        (Scalar.generate options.apiSubmodule definitionsWithExclusions)
        (Graphql.Generator.InputObjectFile.generate context typeDefinitions)


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


excludeSubscription : Context -> List TypeDefinition -> List TypeDefinition
excludeSubscription { subscription } typeDefinitions =
    case subscription of
        Just subscriptionObjectName ->
            typeDefinitions
                |> List.filter (\(Type.TypeDefinition name definableType description) -> name /= subscriptionObjectName)

        Nothing ->
            typeDefinitions


moduleToFileName : List String -> String
moduleToFileName modulePath =
    (modulePath |> String.join "/")
        ++ ".elm"


toPair : Context -> TypeDefinition -> Maybe ( List String, String )
toPair context ((Type.TypeDefinition name definableType description) as definition) =
    ModuleName.generate context definition
        |> Result.toMaybe
        |> Maybe.andThen
            (\moduleName ->
                (case definableType of
                    Type.ObjectType fields ->
                        if name == context.query then
                            Graphql.Generator.Query.generate context moduleName fields
                                |> Result.toMaybe

                        else if Just name == context.mutation then
                            Graphql.Generator.Mutation.generate context moduleName fields
                                |> Result.toMaybe

                        else if Just name == context.subscription then
                            Graphql.Generator.Subscription.generate context moduleName fields
                                |> Result.toMaybe

                        else
                            Graphql.Generator.Object.generate context name moduleName fields
                                |> Result.toMaybe

                    Type.ScalarType ->
                        Nothing

                    Type.EnumType enumValues ->
                        Graphql.Generator.Enum.generate name moduleName enumValues description
                            |> Result.toMaybe

                    Type.InterfaceType fields possibleTypes ->
                        Graphql.Generator.Interface.generate context (ClassCaseName.raw name) moduleName fields
                            |> Result.toMaybe

                    Type.UnionType possibleTypes ->
                        Graphql.Generator.Union.generate context name moduleName possibleTypes
                            |> Result.toMaybe

                    Type.InputObjectType fields ->
                        Nothing
                )
                    |> Maybe.map
                        (\fileContents ->
                            ( moduleName, fileContents )
                        )
            )
