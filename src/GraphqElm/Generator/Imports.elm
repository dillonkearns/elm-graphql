module GraphqElm.Generator.Imports exposing (..)

import GraphqElm.Generator.Object
import GraphqElm.Parser.Type as Type exposing (TypeDefinition, TypeReference)


importsString : List TypeReference -> String
importsString typeRefs =
    typeRefs
        |> List.filterMap imports
        |> List.map toImportString
        |> String.join "\n"


toImportString : List String -> String
toImportString modulePath =
    "import " ++ (modulePath |> String.join ".")


imports : TypeReference -> Maybe (List String)
imports (Type.TypeReference referrableType isNullable) =
    case referrableType of
        Type.Scalar _ ->
            Nothing

        Type.List typeRef ->
            imports typeRef

        Type.ObjectRef objectName ->
            Just (GraphqElm.Generator.Object.moduleNameFor objectName)
