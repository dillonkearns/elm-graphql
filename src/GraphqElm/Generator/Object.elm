module GraphqElm.Generator.Object exposing (..)

import GraphqElm.Generator.Enum
import GraphqElm.Parser.Type as Type exposing (TypeDefinition, TypeReference)
import String.Format


generate : String -> List Type.Field -> ( List String, String )
generate name fields =
    ( moduleNameFor name
    , prepend (moduleNameFor name |> String.join ".")
        ++ (List.map generateField fields |> String.join "\n\n")
    )


moduleNameFor : String -> List String
moduleNameFor name =
    [ "Api", "Object", name ]


prepend : String -> String
prepend moduleName =
    String.Format.format1 """module {1} exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.Field as Field exposing (Field, FieldDecoder)
import GraphqElm.Object as Object exposing (Object)
import GraphqElm.TypeLock exposing (TypeLocked(TypeLocked))
import Json.Decode as Decode


type Type
    = Type


build : (a -> constructor) -> Object (a -> constructor) Type
build constructor =
    Object.object constructor
"""
        moduleName


generateField : Type.Field -> String
generateField { name, typeRef } =
    String.Format.format3
        """{1} : TypeLocked (FieldDecoder {2}) Type
{1} =
    Field.fieldDecoder "{1}" ({3})
"""
        ( name, generateType typeRef, generateDecoder typeRef )


generateBody : Type.Field -> String
generateBody field =
    case field.typeRef of
        Type.TypeReference referrableType isNullable ->
            case referrableType of
                Type.ObjectRef objectName ->
                    String.Format.format2
                        """{1} : List (TypeLocked Argument Api.Object.{2}.Type) -> Object {1} Api.Object.{2}.Type -> Field.Query {1}
{1} optionalArgs object =
    Object.single "{1}" optionalArgs object
        |> Query.rootQuery
"""
                        ( field.name, objectName )

                Type.List (Type.TypeReference (Type.ObjectRef objectName) isObjectNullable) ->
                    """menuItems : List (TypeLocked Argument Api.Object.MenuItem.Type) -> Object menuItem Api.Object.MenuItem.Type -> Field.Query (List menuItem)
menuItems optionalArgs object =
    Object.listOf "menuItems" optionalArgs object
        |> Query.rootQuery
"""

                _ ->
                    String.Format.format3
                        """{1} : Field.Query ({2})
{1} =
    Field.custom "{1}" ({3})
        |> Query.rootQuery
"""
                        ( field.name, generateType field.typeRef, generateDecoder field.typeRef )


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
