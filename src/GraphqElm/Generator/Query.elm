module GraphqElm.Generator.Query exposing (..)

import GraphqElm.Parser.Type as Type exposing (Field, TypeDefinition, TypeReference)
import String.Format


generate : List Field -> ( List String, String )
generate fields =
    ( [ "Query" ]
    , prepend "Query"
        ++ (List.map generateNew fields |> String.join "\n\n")
    )


prepend : String -> String
prepend moduleName =
    String.Format.format1
        """module Api.{1} exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.Field as Field exposing (Field, FieldDecoder)
import GraphqElm.Object as Object exposing (Object)
import GraphqElm.TypeLock exposing (TypeLocked(TypeLocked))
import GraphqElm.Query as Query
import Json.Decode as Decode exposing (Decoder)

type Type
    = Type
"""
        moduleName


generateNew : Type.Field -> String
generateNew field =
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
                        ( field.name, generateType field.typeRef, generateDecoderNew field.typeRef )


generateDecoderNew : TypeReference -> String
generateDecoderNew typeRef =
    case typeRef of
        Type.TypeReference referrableType isNullable ->
            case referrableType of
                Type.Scalar scalar ->
                    "Decode.string"

                Type.List typeRef ->
                    generateDecoderNew typeRef ++ " |> Decode.list"

                Type.ObjectRef objectName ->
                    "Api.Object." ++ objectName ++ ".decoder"


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
