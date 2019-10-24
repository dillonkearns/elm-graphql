module Graphql.Generator.ModuleName exposing (enum, enumTypeName, generate, inputObject, interface, mutation, object, query, union)

import Graphql.Generator.Context exposing (Context)
import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphql.Parser.Type as Type exposing (TypeDefinition(..))


generate : Context -> TypeDefinition -> Result String (List String)
generate context (Type.TypeDefinition name definableType description) =
    case definableType of
        Type.ObjectType fields ->
            if name == context.query then
                query context
                    |> Ok

            else if Just name == context.mutation then
                mutation context
                    |> Ok

            else if Just name == context.subscription then
                subscription context
                    |> Ok

            else
                object context name

        Type.ScalarType ->
            Ok []

        Type.EnumType enumValues ->
            enum context name

        Type.InterfaceType fields possibleTypes ->
            interface context name

        Type.UnionType possibleTypes ->
            union context name

        Type.InputObjectType _ ->
            inputObject context name
                |> Ok


object : Context -> ClassCaseName -> Result String (List String)
object context name =
    if name == context.query then
        Ok [ "RootQuery" ]

    else if Just name == context.mutation then
        Ok [ "RootMutation" ]

    else if Just name == context.subscription then
        Ok [ "RootSubscription" ]

    else
        name
            |> ClassCaseName.normalized
            |> Result.map
                (\name_ ->
                    context.apiSubmodule ++ [ "Object", name_ ]
                )


inputObject : { context | apiSubmodule : List String } -> ClassCaseName -> List String
inputObject { apiSubmodule } name =
    apiSubmodule ++ [ "InputObject" ]


interface : Context -> ClassCaseName -> Result String (List String)
interface { apiSubmodule } =
    ClassCaseName.normalized
        >> Result.map
            (\name ->
                apiSubmodule ++ [ "Interface", name ]
            )


union : Context -> ClassCaseName -> Result String (List String)
union { apiSubmodule } =
    ClassCaseName.normalized
        >> Result.map
            (\name ->
                apiSubmodule ++ [ "Union", name ]
            )


enum : { context | apiSubmodule : List String } -> ClassCaseName -> Result String (List String)
enum { apiSubmodule } =
    ClassCaseName.normalized
        >> Result.map
            (\name ->
                apiSubmodule ++ [ "Enum", name ]
            )


enumTypeName : { context | apiSubmodule : List String } -> ClassCaseName -> Result String (List String)
enumTypeName { apiSubmodule } =
    ClassCaseName.normalized
        >> Result.map
            (\name ->
                apiSubmodule ++ [ "Enum", name, name ]
            )


query : { context | apiSubmodule : List String } -> List String
query { apiSubmodule } =
    apiSubmodule ++ [ "Query" ]


mutation : { context | apiSubmodule : List String } -> List String
mutation { apiSubmodule } =
    apiSubmodule ++ [ "Mutation" ]


subscription : { context | apiSubmodule : List String } -> List String
subscription { apiSubmodule } =
    apiSubmodule ++ [ "Subscription" ]
