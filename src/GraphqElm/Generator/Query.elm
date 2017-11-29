module GraphqElm.Generator.Query exposing (..)

import GraphqElm.Parser.Type as Type exposing (TypeReference)
import String.Format


generateNew : Type.Field -> String
generateNew field =
    case field.typeRef of
        Type.TypeReference referrableType isNullable ->
            case referrableType of
                Type.ObjectRef objectName ->
                    String.Format.format2
                        """{1} : List (TypeLocked Argument Api.{2}.Type) -> Object {1} Api.{2}.Type -> Field.Query {1}
{1} optionalArgs object =
    Object.single "{1}" optionalArgs object
        |> Query.rootQuery
"""
                        ( field.name, objectName )

                Type.List (Type.TypeReference (Type.ObjectRef objectName) isObjectNullable) ->
                    """menuItems : List (TypeLocked Argument Api.MenuItem.Type) -> Object menuItem Api.MenuItem.Type -> Field.Query (List menuItem)
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



{-

   menuItem : { id : String } -> List (TypeLocked Argument MenuItem.Type) -> Object menuItem MenuItem.Type -> Field.Query menuItem
   menuItem requiredArgs optionalArgs object =
       Object.single "menuItem" (MenuItem.idArg requiredArgs.id :: optionalArgs) object
           |> Query.rootQuery

-}


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
