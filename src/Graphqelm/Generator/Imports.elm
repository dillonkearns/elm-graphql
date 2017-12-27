module Graphqelm.Generator.Imports exposing (..)

import Graphqelm.Generator.Enum
import Graphqelm.Generator.SpecialObjectNames exposing (SpecialObjectNames)
import Graphqelm.Parser.Type as Type exposing (TypeDefinition, TypeReference)


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
        |> List.map toModuleName
        |> List.map toImportString
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
            Just (Graphqelm.Generator.Enum.moduleNameFor apiSubmodule enumName)

        Type.InputObjectRef _ ->
            Nothing


object : List String -> SpecialObjectNames -> String -> List String
object apiSubmodule { query, mutation } name =
    if name == query then
        [ "RootQuery" ]
    else if Just name == mutation then
        [ "RootMutation" ]
    else
        apiSubmodule ++ [ "Object", name ]
