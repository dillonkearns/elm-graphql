module GraphqElm.Generator.Imports exposing (..)

import GraphqElm.Generator.Object
import GraphqElm.Parser.Type as Type exposing (TypeDefinition, TypeReference)


imports : TypeReference -> Maybe (List String)
imports (Type.TypeReference referrableType isNullable) =
    case referrableType of
        Type.Scalar _ ->
            Nothing

        Type.List typeRef ->
            imports typeRef

        Type.ObjectRef objectName ->
            Just (GraphqElm.Generator.Object.moduleNameFor objectName)
