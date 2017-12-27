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


importsString : List String -> List Type.Field -> String
importsString importingFrom typeRefs =
    typeRefs
        |> allRefs
        |> importsWithoutSelf importingFrom
        |> List.map toModuleName
        |> List.map toImportString
        |> String.join "\n"


importsWithoutSelf : List String -> List TypeReference -> List (List String)
importsWithoutSelf importingFrom typeRefs =
    typeRefs
        |> List.filterMap imports
        |> List.filter (\moduleName -> moduleName /= importingFrom)


toModuleName : List String -> String
toModuleName modulePath =
    modulePath |> String.join "."


toImportString : String -> String
toImportString moduleName =
    "import " ++ moduleName


imports : TypeReference -> Maybe (List String)
imports (Type.TypeReference referrableType isNullable) =
    case referrableType of
        Type.Scalar _ ->
            Nothing

        Type.List typeRef ->
            imports typeRef

        Type.ObjectRef objectName ->
            Nothing

        Type.InterfaceRef interfaceName ->
            Nothing

        Type.EnumRef enumName ->
            Just (Graphqelm.Generator.Enum.moduleNameFor enumName)

        Type.InputObjectRef _ ->
            Nothing


object : SpecialObjectNames -> String -> List String
object { query, mutation } name =
    if name == query then
        [ "RootQuery" ]
    else
        [ "Api", "Object", name ]
