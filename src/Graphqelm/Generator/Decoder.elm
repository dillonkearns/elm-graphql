module Graphqelm.Generator.Decoder exposing (generateDecoder, generateEncoder, generateType)

import Graphqelm.Generator.Enum
import Graphqelm.Parser.Scalar as Scalar
import Graphqelm.Parser.Type as Type exposing (TypeReference)


generateDecoder : List String -> TypeReference -> List String
generateDecoder apiSubmodule typeRef =
    case typeRef of
        Type.TypeReference referrableType isNullable ->
            case referrableType of
                Type.Scalar scalar ->
                    case scalar of
                        Scalar.String ->
                            [ "Decode.string" ]

                        Scalar.Boolean ->
                            [ "Decode.bool" ]

                        Scalar.Int ->
                            [ "Decode.int" ]

                        Scalar.Float ->
                            [ "Decode.float" ]

                Type.List listTypeRef ->
                    generateDecoder apiSubmodule listTypeRef ++ [ "Decode.list" ]

                Type.ObjectRef objectName ->
                    [ "identity" ]

                Type.InterfaceRef interfaceName ->
                    [ "identity" ]

                Type.EnumRef enumName ->
                    [ (Graphqelm.Generator.Enum.moduleNameFor apiSubmodule enumName
                        ++ [ "decoder" ]
                      )
                        |> String.join "."
                    ]

                Type.InputObjectRef _ ->
                    Debug.crash "Input objects are only for input not responses, shouldn't need decoder."


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
                    "(Encode.enum toString)"

                Type.InputObjectRef inputObjectName ->
                    "identity"


generateType : List String -> String -> TypeReference -> String
generateType apiSubmodule fieldName typeRef =
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
                    "(List " ++ generateType apiSubmodule fieldName typeRef ++ ")"

                Type.ObjectRef objectName ->
                    fieldName

                Type.InterfaceRef interfaceName ->
                    fieldName

                Type.EnumRef enumName ->
                    Graphqelm.Generator.Enum.moduleNameFor apiSubmodule enumName
                        ++ [ enumName ]
                        |> String.join "."

                Type.InputObjectRef _ ->
                    "Value"
