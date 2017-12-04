module Graphqelm.Generator.Decoder exposing (generateDecoder, generateType)

import Graphqelm.Generator.Enum
import Graphqelm.Parser.Type as Type exposing (Field, TypeDefinition, TypeReference)


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
                    Graphqelm.Generator.Enum.moduleNameFor enumName
                        ++ [ "decoder" ]
                        |> String.join "."


generateType : TypeReference -> String
generateType typeRef =
    case typeRef of
        Type.TypeReference referrableType isNullable ->
            case referrableType of
                Type.Scalar scalar ->
                    "String"

                Type.List typeRef ->
                    "(List " ++ generateType typeRef ++ ")"

                Type.ObjectRef objectName ->
                    "Object." ++ objectName

                Type.InterfaceRef interfaceName ->
                    "Object." ++ interfaceName

                Type.EnumRef enumName ->
                    Graphqelm.Generator.Enum.moduleNameFor enumName
                        ++ [ enumName ]
                        |> String.join "."
