module GraphqElm.Generator.Query exposing (..)

import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.Type as Type exposing (TypeDefinition)
import GraphqElm.Parser.TypeNew as TypeNew exposing (TypeReference)
import String.Format


generateNew : TypeNew.Field -> String
generateNew { name, typeRef } =
    String.Format.format3
        """{1} : Field.Query ({2})
{1} =
    Field.custom "{1}" ({3})
        |> Query.rootQuery
"""
        ( name, generateTypeNew typeRef, generateDecoderNew typeRef )


generate : { name : String, typeOf : TypeDefinition } -> String
generate { name, typeOf } =
    String.Format.format3
        """{1} : Field.Query ({2})
{1} =
    Field.custom "{1}" ({3})
        |> Query.rootQuery
"""
        ( name, generateType typeOf, generateDecoder typeOf )


generateDecoderNew : TypeReference -> String
generateDecoderNew typeRef =
    case typeRef of
        TypeNew.TypeReference referrableType isNullable ->
            case referrableType of
                TypeNew.Scalar scalar ->
                    "Decode.string"

                TypeNew.List typeRef ->
                    "Decode.string |> Decode.list"


generateTypeNew : TypeReference -> String
generateTypeNew typeRef =
    case typeRef of
        TypeNew.TypeReference referrableType isNullable ->
            case referrableType of
                TypeNew.Scalar scalar ->
                    "String"

                TypeNew.List typeRef ->
                    "List String"


generateDecoder : TypeDefinition -> String
generateDecoder typeOf =
    case typeOf of
        Type.List Type.NonNullable (Type.Scalar Type.NonNullable Scalar.String) ->
            "Decode.string |> Decode.list"

        Type.Scalar isNullable scalar ->
            "Decode.string"

        Type.List isNullable type_ ->
            "Decode.string |> Decode.list"

        Type.Object _ _ ->
            Debug.crash "TODO"


generateType : TypeDefinition -> String
generateType typeOf =
    case typeOf of
        Type.List Type.NonNullable (Type.Scalar Type.NonNullable Scalar.String) ->
            "List String"

        Type.Scalar isNullable scalar ->
            "String"

        Type.List isNullable type_ ->
            "List String"

        Type.Object _ _ ->
            Debug.crash "TODO"
