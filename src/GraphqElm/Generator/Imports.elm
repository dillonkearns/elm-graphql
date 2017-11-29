module GraphqElm.Generator.Imports exposing (..)

import GraphqElm.Parser.Type as Type exposing (TypeDefinition, TypeReference)


imports : TypeReference -> List String
imports (Type.TypeReference referrableType isNullable) =
    case referrableType of
        Type.Scalar _ ->
            []

        Type.List typeRef ->
            imports typeRef

        Type.ObjectRef objectName ->
            [ objectName ]
