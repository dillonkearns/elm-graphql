module GraphqElm.Generator.Query exposing (..)

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
