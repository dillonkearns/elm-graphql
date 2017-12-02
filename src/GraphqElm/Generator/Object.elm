module GraphqElm.Generator.Object exposing (..)

import GraphqElm.Generator.Enum
import GraphqElm.Generator.Imports as Imports
import GraphqElm.Parser.Type as Type exposing (Field, TypeDefinition, TypeReference)
import String.Format


generate : String -> List Type.Field -> ( List String, String )
generate name fields =
    ( Imports.object name
    , prepend (Imports.object name) fields
        ++ (List.map (generateNew name) fields |> String.join "\n\n")
    )


prepend : List String -> List Type.Field -> String
prepend moduleName fields =
    let
        imports : String
        imports =
            fields
                |> List.map (\{ name, typeRef } -> typeRef)
                |> Imports.importsString moduleName
    in
    String.Format.format1 """module {1} exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.Field as Field exposing (Field, FieldDecoder)
import GraphqElm.Object as Object exposing (Object)
import GraphqElm.TypeLock exposing (TypeLocked(TypeLocked))
import Json.Decode as Decode
"""
        (moduleName |> String.join ".")
        ++ imports
        ++ """


type Type
    = Type


build : (a -> constructor) -> Object (a -> constructor) Type
build constructor =
    Object.object constructor
"""


generateNew : String -> Type.Field -> String
generateNew thisObjectName field =
    case field.typeRef of
        Type.TypeReference referrableType isNullable ->
            case referrableType of
                Type.ObjectRef objectName ->
                    let
                        typeLockName =
                            if thisObjectName == objectName then
                                "Type"
                            else
                                Imports.object objectName ++ [ "Type" ] |> String.join "."
                    in
                    String.Format.format2
                        """{1} : Object {1} {2} -> Field.Query {1}
{1} object =
    Object.single "{1}" [] object
"""
                        ( field.name, typeLockName )

                Type.InterfaceRef interfaceName ->
                    let
                        typeLockName =
                            if thisObjectName == interfaceName then
                                "Type"
                            else
                                Imports.object interfaceName ++ [ "Type" ] |> String.join "."
                    in
                    String.Format.format2
                        """{1} : Object {1} {2} -> Field.Query {1}
{1} object =
    Object.single "{1}" [] object
      |> TypeLocked
"""
                        ( field.name, typeLockName )

                Type.List (Type.TypeReference (Type.InterfaceRef objectName) isNullable) ->
                    let
                        typeLockName =
                            if thisObjectName == objectName then
                                "Type"
                            else
                                Imports.object objectName ++ [ "Type" ] |> String.join "."
                    in
                    String.Format.format3
                        """{1} : Object {3} {2} -> TypeLocked (FieldDecoder (List {3})) Type
{1} object =
    Object.listOf "{3}" [] object
      |> TypeLocked
"""
                        ( field.name, typeLockName, field.name )

                _ ->
                    generateField field


generateField : Type.Field -> String
generateField { name, typeRef } =
    String.Format.format3
        """{1} : TypeLocked (FieldDecoder {2}) Type
{1} =
    Field.fieldDecoder "{1}" ({3})
"""
        ( name, generateType typeRef, generateDecoder typeRef )


generateDecoder : TypeReference -> String
generateDecoder typeRef =
    case typeRef of
        Type.TypeReference referrableType isNullable ->
            case referrableType of
                Type.Scalar scalar ->
                    "Decode.string"

                Type.List typeRef ->
                    generateDecoder typeRef ++ " |> Decode.list"

                Type.ObjectRef objectName ->
                    "Api.Object." ++ objectName ++ ".decoder"

                Type.InterfaceRef interfaceName ->
                    "Api.Object." ++ interfaceName ++ ".decoder"

                Type.EnumRef enumName ->
                    GraphqElm.Generator.Enum.moduleNameFor enumName ++ [ "decoder" ] |> String.join "."


generateType : TypeReference -> String
generateType typeRef =
    case typeRef of
        Type.TypeReference referrableType isNullable ->
            case referrableType of
                Type.Scalar scalar ->
                    "String"

                Type.List typeRef ->
                    "List String"

                Type.ObjectRef objectName ->
                    "Object." ++ objectName

                Type.InterfaceRef interfaceName ->
                    "Object." ++ interfaceName

                Type.EnumRef _ ->
                    "ENUMTYPETODO"
