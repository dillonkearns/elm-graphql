module Graphqelm.Generator.Decoder exposing (generateDecoder, generateEncoder, generateType)

import Graphqelm.Generator.Imports as Imports
import Graphqelm.Parser.Scalar as Scalar
import Graphqelm.Parser.Type as Type exposing (TypeReference)


generateDecoder : List String -> TypeReference -> List String
generateDecoder apiSubmodule (Type.TypeReference referrableType isNullable) =
    (case referrableType of
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
            [ (Imports.enum { apiSubmodule = apiSubmodule } enumName
                ++ [ "decoder" ]
              )
                |> String.join "."
            ]

        Type.InputObjectRef _ ->
            Debug.crash "Input objects are only for input not responses, shouldn't need decoder."
    )
        ++ (case isNullable of
                Type.Nullable ->
                    [ "Decode.maybe" ]

                Type.NonNullable ->
                    []
           )


generateEncoder : TypeReference -> String
generateEncoder (Type.TypeReference referrableType isNullable) =
    let
        isNullableString =
            case isNullable of
                Type.Nullable ->
                    " |> Encode.maybe"

                Type.NonNullable ->
                    ""
    in
    case referrableType of
        Type.Scalar scalar ->
            case scalar of
                Scalar.String ->
                    "Encode.string" ++ isNullableString

                Scalar.Boolean ->
                    "Encode.bool" ++ isNullableString

                Scalar.Int ->
                    "Encode.int" ++ isNullableString

                Scalar.Float ->
                    "Encode.float" ++ isNullableString

        Type.List typeRef ->
            generateEncoder typeRef ++ isNullableString ++ " |> Encode.list"

        Type.ObjectRef objectName ->
            Debug.crash "I don't expect to see object references as argument types."

        Type.InterfaceRef interfaceName ->
            Debug.crash "I don't expect to see object references as argument types."

        Type.EnumRef enumName ->
            "(Encode.enum toString)" ++ isNullableString

        Type.InputObjectRef inputObjectName ->
            "identity" ++ isNullableString


generateType : List String -> String -> TypeReference -> String
generateType apiSubmodule fieldName (Type.TypeReference referrableType isNullable) =
    (case referrableType of
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
            Imports.enum { apiSubmodule = apiSubmodule } enumName
                ++ [ enumName ]
                |> String.join "."

        Type.InputObjectRef _ ->
            "Value"
    )
        |> (\typeString ->
                case isNullable of
                    Type.Nullable ->
                        "(Maybe " ++ typeString ++ ")"

                    Type.NonNullable ->
                        typeString
           )
