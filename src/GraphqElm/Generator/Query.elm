module GraphqElm.Generator.Query exposing (..)

import GraphqElm.Parser.Type as Type exposing (TypeReference)
import String.Format


generateNew : Type.Field -> String
generateNew { name, typeRef } =
    String.Format.format3
        """{1} : Field.Query ({2})
{1} =
    Field.custom "{1}" ({3})
        |> Query.rootQuery
"""
        ( name, generateType typeRef, generateDecoderNew typeRef )


generateDecoderNew : TypeReference -> String
generateDecoderNew typeRef =
    case typeRef of
        Type.TypeReference referrableType isNullable ->
            case referrableType of
                Type.Scalar scalar ->
                    "Decode.string"

                Type.List typeRef ->
                    "Decode.string |> Decode.list"


generateType : TypeReference -> String
generateType typeRef =
    case typeRef of
        Type.TypeReference referrableType isNullable ->
            case referrableType of
                Type.Scalar scalar ->
                    "String"

                Type.List typeRef ->
                    "List String"
