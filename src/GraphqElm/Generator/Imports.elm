module Graphqelm.Generator.Imports exposing (..)

import Graphqelm.Generator.Enum
import Graphqelm.Parser.Type as Type exposing (TypeDefinition, TypeReference)


importsString : List String -> List TypeReference -> String
importsString importingFrom typeRefs =
    typeRefs
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
            Just (object objectName)

        Type.InterfaceRef interfaceName ->
            Just (object interfaceName)

        Type.EnumRef enumName ->
            Just (Graphqelm.Generator.Enum.moduleNameFor enumName)


object : String -> List String
object name =
    [ "Api", "Object", name ]
