module Graphql.Generator.ModuleName exposing (enum, enumTypeName, generate, inputObject, interface, object, union)

import Elm.Annotation
import Graphql.Generator.Context exposing (Context)
import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphql.Parser.Type as Type exposing (TypeDefinition(..))


generate : Context -> TypeDefinition -> List String
generate context (Type.TypeDefinition name definableType description) =
    case definableType of
        Type.ObjectType fields ->
            if name == context.query then
                query context

            else if Just name == context.mutation then
                mutation context

            else if Just name == context.subscription then
                subscription context

            else
                object context name

        Type.ScalarType ->
            []

        Type.EnumType enumValues ->
            enum context name

        Type.InterfaceType fields possibleTypes ->
            interface context name

        Type.UnionType possibleTypes ->
            union context name

        Type.InputObjectType _ ->
            inputObject context name


object : Context -> ClassCaseName -> List String
object context name =
    if name == context.query then
        [ "RootQuery" ]

    else if Just name == context.mutation then
        [ "RootMutation" ]

    else if Just name == context.subscription then
        [ "RootSubscription" ]

    else
        context.apiSubmodule ++ [ "Object", ClassCaseName.normalized name ]


inputObject : { context | apiSubmodule : List String } -> ClassCaseName -> List String
inputObject { apiSubmodule } name =
    apiSubmodule ++ [ "InputObject" ]


interface : Context -> ClassCaseName -> List String
interface { apiSubmodule } name =
    apiSubmodule ++ [ "Interface", ClassCaseName.normalized name ]


union : Context -> ClassCaseName -> List String
union { apiSubmodule } name =
    apiSubmodule ++ [ "Union", ClassCaseName.normalized name ]


enum : { context | apiSubmodule : List String } -> ClassCaseName -> List String
enum { apiSubmodule } name =
    apiSubmodule ++ [ "Enum", ClassCaseName.normalized name ]


enumTypeName : { context | apiSubmodule : List String } -> ClassCaseName -> Elm.Annotation.Annotation
enumTypeName { apiSubmodule } name =
    Elm.Annotation.named
        (apiSubmodule ++ [ "Enum", ClassCaseName.normalized name ])
        (ClassCaseName.normalized name)


query : { context | apiSubmodule : List String } -> List String
query { apiSubmodule } =
    apiSubmodule ++ [ "Query" ]


mutation : { context | apiSubmodule : List String } -> List String
mutation { apiSubmodule } =
    apiSubmodule ++ [ "Mutation" ]


subscription : { context | apiSubmodule : List String } -> List String
subscription { apiSubmodule } =
    apiSubmodule ++ [ "Subscription" ]
