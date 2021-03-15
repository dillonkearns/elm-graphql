module Graphql.Generator.InputObjectLoops exposing (any, hasLoop)

import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphql.Parser.Type as Type exposing (DefinableType(..), Field, IsNullable(..), ReferrableType(..), TypeDefinition(..), TypeReference(..))
import List.Extra


any : List TypeDefinition -> Bool
any typeDefs =
    List.any (hasLoop typeDefs) typeDefs


hasLoop : List TypeDefinition -> TypeDefinition -> Bool
hasLoop typeDefs (TypeDefinition name definableType description) =
    case definableType of
        InputObjectType fields ->
            fields
                |> List.map .typeRef
                |> List.any (fieldIsCircular typeDefs name)

        _ ->
            False


fieldIsCircular : List TypeDefinition -> ClassCaseName -> TypeReference -> Bool
fieldIsCircular typeDefs inputObjectName fieldTypeRef =
    fieldIsCircular_ [] typeDefs inputObjectName fieldTypeRef


fieldIsCircular_ : List ClassCaseName -> List TypeDefinition -> ClassCaseName -> TypeReference -> Bool
fieldIsCircular_ visitedNames typeDefs inputObjectName fieldTypeRef =
    let
        alreadyVisitedThis =
            visitedNames
                |> List.map ClassCaseName.raw
                |> List.Extra.allDifferent
    in
    case fieldTypeRef of
        TypeReference referrableType isNullable ->
            case referrableType of
                InputObjectRef inputObjectRefName ->
                    case lookupInputObject typeDefs inputObjectRefName of
                        Just ( name, fields ) ->
                            not alreadyVisitedThis
                                || isRecursive inputObjectName fields
                                || List.any
                                    (fieldIsCircular_ (inputObjectName :: visitedNames) typeDefs name)
                                    (fields |> List.map .typeRef)

                        Nothing ->
                            False

                Type.List listTypeRef ->
                    fieldIsCircular_ visitedNames typeDefs inputObjectName listTypeRef

                _ ->
                    False


lookupInputObject : List TypeDefinition -> ClassCaseName -> Maybe ( ClassCaseName, List Field )
lookupInputObject typeDefs inputObjectName =
    List.filterMap
        (\(TypeDefinition name definableType description) ->
            case definableType of
                InputObjectType fields ->
                    if name == inputObjectName then
                        Just ( name, fields )

                    else
                        Nothing

                _ ->
                    Nothing
        )
        typeDefs
        |> List.head


isRecursive : ClassCaseName -> List Field -> Bool
isRecursive inputObjectName fields =
    List.any (fieldIsRecursive inputObjectName) fields


fieldIsRecursive : ClassCaseName -> Field -> Bool
fieldIsRecursive inputObjectName field =
    case field.typeRef of
        TypeReference referrableType isNullable ->
            hasRecursiveRef inputObjectName referrableType


hasRecursiveRef : ClassCaseName -> ReferrableType -> Bool
hasRecursiveRef inputObjectName referrableType =
    case referrableType of
        InputObjectRef referredInputObjectName ->
            inputObjectName == referredInputObjectName

        Type.List listTypeRef ->
            case listTypeRef of
                Type.TypeReference listType isNullable ->
                    hasRecursiveRef inputObjectName listType

        Type.Scalar _ ->
            False

        Type.EnumRef _ ->
            False

        Type.ObjectRef _ ->
            False

        Type.UnionRef _ ->
            False

        Type.InterfaceRef _ ->
            False
