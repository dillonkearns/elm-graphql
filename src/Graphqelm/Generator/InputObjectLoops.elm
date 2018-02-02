module Graphqelm.Generator.InputObjectLoops exposing (any)

import Graphqelm.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphqelm.Parser.Type exposing (DefinableType(..), Field, IsNullable(NonNullable), ReferrableType(InputObjectRef), TypeDefinition(TypeDefinition), TypeReference(TypeReference))


any : List TypeDefinition -> Bool
any typeDefs =
    List.any hasLoop typeDefs


hasLoop : TypeDefinition -> Bool
hasLoop (TypeDefinition name definableType description) =
    case definableType of
        InputObjectType fields ->
            isRecursive name fields

        _ ->
            False


isRecursive : ClassCaseName -> List Field -> Bool
isRecursive inputObjectName fields =
    List.any (fieldIsRecursive inputObjectName) fields


fieldIsRecursive : ClassCaseName -> Field -> Bool
fieldIsRecursive inputObjectName field =
    Just inputObjectName
        == (case field.typeRef of
                TypeReference referrableType isNullable ->
                    case referrableType of
                        InputObjectRef fieldName ->
                            Just fieldName

                        _ ->
                            Nothing
           )
