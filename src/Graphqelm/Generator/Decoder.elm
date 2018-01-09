module Graphqelm.Generator.Decoder exposing (generateDecoder, generateEncoder, generateEncoderLowLevel, generateType, generateTypeForInputObject)

import Graphqelm.Generator.ModuleName as ModuleName
import Graphqelm.Parser.ClassCaseName as ClassCaseName
import Graphqelm.Parser.Scalar as Scalar
import Graphqelm.Parser.Type as Type exposing (TypeReference)
import Interpolate exposing (interpolate)


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

                Scalar.Custom customScalarName ->
                    let
                        constructor =
                            apiSubmodule
                                ++ [ "Scalar" ]
                                ++ [ ClassCaseName.normalized customScalarName ]
                                |> String.join "."
                    in
                    [ "Decode.string"
                    , interpolate "Decode.map {0}" [ constructor ]
                    ]

        Type.List listTypeRef ->
            generateDecoder apiSubmodule listTypeRef ++ [ "Decode.list" ]

        Type.ObjectRef objectName ->
            [ "identity" ]

        Type.InterfaceRef interfaceName ->
            [ "identity" ]

        Type.UnionRef unionName ->
            [ "identity" ]

        Type.EnumRef enumName ->
            [ (ModuleName.enum { apiSubmodule = apiSubmodule } enumName
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


generateEncoderLowLevel : List String -> Type.ReferrableType -> String
generateEncoderLowLevel apiSubmodule referrableType =
    generateEncoder apiSubmodule (Type.TypeReference referrableType Type.NonNullable)


generateEncoder : List String -> TypeReference -> String
generateEncoder apiSubmodule (Type.TypeReference referrableType isNullable) =
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

                Scalar.Custom customScalarName ->
                    let
                        constructor =
                            apiSubmodule
                                ++ [ "Scalar" ]
                                ++ [ ClassCaseName.normalized customScalarName ]
                                |> String.join "."
                    in
                    -- "identity"
                    interpolate "(\\({0} raw) -> Encode.string raw)" [ constructor ]

        Type.List typeRef ->
            generateEncoder apiSubmodule typeRef ++ isNullableString ++ " |> Encode.list"

        Type.ObjectRef objectName ->
            Debug.crash "I don't expect to see object references as argument types."

        Type.InterfaceRef interfaceName ->
            Debug.crash "Interfaces are never valid inputs http://facebook.github.io/graphql/October2016/#sec-Interfaces"

        Type.UnionRef _ ->
            Debug.crash "Unions are never valid inputs http://facebook.github.io/graphql/October2016/#sec-Unions"

        Type.EnumRef enumName ->
            interpolate ("(Encode.enum {0})" ++ isNullableString)
                [ ModuleName.enum { apiSubmodule = apiSubmodule } enumName
                    ++ [ "toString" ]
                    |> String.join "."
                ]

        Type.InputObjectRef inputObjectName ->
            ((ModuleName.inputObject { apiSubmodule = apiSubmodule } inputObjectName
                ++ [ "encode" ]
             )
                |> String.join "."
            )
                ++ isNullableString


generateType : List String -> TypeReference -> String
generateType apiSubmodule typeRef =
    generateTypeCommon "Maybe" apiSubmodule typeRef


generateTypeForInputObject : List String -> TypeReference -> String
generateTypeForInputObject apiSubmodule typeRef =
    generateTypeCommon "OptionalArgument" apiSubmodule typeRef


generateTypeCommon : String -> List String -> TypeReference -> String
generateTypeCommon nullableString apiSubmodule (Type.TypeReference referrableType isNullable) =
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

                Scalar.Custom customScalarName ->
                    let
                        constructor =
                            apiSubmodule
                                ++ [ "Scalar" ]
                                ++ [ ClassCaseName.normalized customScalarName ]
                                |> String.join "."
                    in
                    constructor

        Type.List typeRef ->
            "(List " ++ generateType apiSubmodule typeRef ++ ")"

        Type.ObjectRef objectName ->
            "selection"

        Type.InterfaceRef interfaceName ->
            "selection"

        Type.UnionRef unionName ->
            "selection"

        Type.EnumRef enumName ->
            ModuleName.enumTypeName { apiSubmodule = apiSubmodule } enumName
                |> String.join "."

        Type.InputObjectRef inputObjectName ->
            (ModuleName.inputObject { apiSubmodule = apiSubmodule } inputObjectName
                ++ [ ClassCaseName.normalized inputObjectName ]
            )
                |> String.join "."
    )
        |> (\typeString ->
                case isNullable of
                    Type.Nullable ->
                        interpolate "({0} {1})" [ nullableString, typeString ]

                    Type.NonNullable ->
                        typeString
           )
