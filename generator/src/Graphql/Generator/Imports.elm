module Graphql.Generator.Imports exposing (imports, importsString, importsWithoutSelf)

import Graphql.Generator.ModuleName as ModuleName
import Graphql.Parser.Type as Type exposing (TypeReference)


allRefs : List Type.Field -> List TypeReference
allRefs fields =
    List.concatMap getArgRefs fields
        ++ List.map (\{ typeRef } -> typeRef) fields


getArgRefs : Type.Field -> List TypeReference
getArgRefs { args } =
    List.map .typeRef args


importsString : List String -> List String -> List Type.Field -> String
importsString apiSubmodule importingFrom typeRefs =
    typeRefs
        |> allRefs
        |> importsWithoutSelf apiSubmodule importingFrom
        |> List.map (toModuleName >> toImportString)
        |> String.join "\n"


importsWithoutSelf : List String -> List String -> List TypeReference -> List (List String)
importsWithoutSelf apiSubmodule importingFrom typeRefs =
    typeRefs
        |> List.filterMap (imports apiSubmodule)
        |> List.filter (\moduleName -> moduleName /= importingFrom)


toModuleName : List String -> String
toModuleName modulePath =
    modulePath |> String.join "."


toImportString : String -> String
toImportString moduleName =
    "import " ++ moduleName


imports : List String -> TypeReference -> Maybe (List String)
imports apiSubmodule (Type.TypeReference referrableType isNullable) =
    case referrableType of
        Type.Scalar _ ->
            Nothing

        Type.List typeRef ->
            imports apiSubmodule typeRef

        Type.ObjectRef objectName ->
            Nothing

        Type.InterfaceRef interfaceName ->
            Nothing

        Type.EnumRef enumName ->
            Just (ModuleName.enum { apiSubmodule = apiSubmodule } enumName)

        Type.InputObjectRef inputObjectName ->
            Nothing

        Type.UnionRef unionName ->
            Nothing
