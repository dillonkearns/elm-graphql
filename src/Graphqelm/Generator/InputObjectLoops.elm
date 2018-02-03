module Graphqelm.Generator.InputObjectLoops exposing (any)

import Graphqelm.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphqelm.Parser.Type as Type exposing (DefinableType(..), Field, IsNullable(NonNullable), ReferrableType(InputObjectRef), TypeDefinition(TypeDefinition), TypeReference(TypeReference))


any : List TypeDefinition -> Bool
any typeDefs =
    List.any (hasLoop typeDefs) typeDefs


hasLoop : List TypeDefinition -> TypeDefinition -> Bool
hasLoop typeDefs (TypeDefinition name definableType description) =
    case definableType of
        InputObjectType fields ->
            isCircular typeDefs name fields

        _ ->
            False


isCircular : List TypeDefinition -> ClassCaseName -> List Field -> Bool
isCircular typeDefs inputObjectName fields =
    List.any (fieldIsCircular typeDefs inputObjectName) fields


fieldIsCircular : List TypeDefinition -> ClassCaseName -> Field -> Bool
fieldIsCircular typeDefs inputObjectName field =
    case field.typeRef of
        TypeReference referrableType isNullable ->
            case referrableType of
                InputObjectRef inputObjectRefName ->
                    case lookupInputObject typeDefs inputObjectRefName of
                        Just ( name, fields ) ->
                            isRecursive inputObjectName fields
                                || List.any
                                    (fieldIsCircular typeDefs inputObjectName)
                                    fields

                        Nothing ->
                            False

                Type.List typeRef ->
                    False

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
            case referrableType of
                InputObjectRef referredInputObjectName ->
                    inputObjectName == referredInputObjectName

                _ ->
                    False
