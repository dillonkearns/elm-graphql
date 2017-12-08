module Graphqelm.Generator.Decoder exposing (generateDecoder, generateEncoder, generateType)

import Graphqelm.Generator.Enum
import Graphqelm.Parser.Scalar as Scalar
import Graphqelm.Parser.Type as Type exposing (Field, TypeDefinition, TypeReference)


generateDecoder : TypeReference -> String
generateDecoder typeRef =
    case typeRef of
        Type.TypeReference referrableType isNullable ->
            case referrableType of
                Type.Scalar scalar ->
                    case scalar of
                        Scalar.String ->
                            "Decode.string"

                        Scalar.Boolean ->
                            "Decode.bool"

                        Scalar.Int ->
                            "Decode.int"

                        Scalar.Float ->
                            "Decode.float"

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


generateEncoder : TypeReference -> String
generateEncoder typeRef =
    case typeRef of
        Type.TypeReference referrableType isNullable ->
            case referrableType of
                Type.Scalar scalar ->
                    case scalar of
                        Scalar.String ->
                            "Encode.string"

                        Scalar.Boolean ->
                            "Encode.bool"

                        Scalar.Int ->
                            "Encode.int"

                        Scalar.Float ->
                            "Encode.float"

                Type.List typeRef ->
                    generateEncoder typeRef ++ " |> Encode.list"

                Type.ObjectRef objectName ->
                    Debug.crash "I don't expect to see object references as argument types."

                Type.InterfaceRef interfaceName ->
                    Debug.crash "I don't expect to see object references as argument types."

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
                    case scalar of
                        Scalar.String ->
                            "String"

                        Scalar.Boolean ->
                            "Bool"

                        Scalar.Int ->
                            "Int"

                        Scalar.Float ->
                            "Float"

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
