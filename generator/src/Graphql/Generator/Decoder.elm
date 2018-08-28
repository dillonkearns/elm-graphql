module Graphql.Generator.Decoder exposing (generateDecoder, generateEncoder, generateEncoderLowLevel, generateType, generateTypeForInputObject)

import Graphql.Generator.ModuleName as ModuleName
import Graphql.Parser.ClassCaseName as ClassCaseName
import Graphql.Parser.Scalar as Scalar
import Graphql.Parser.Type as Type exposing (TypeReference)
import String.Interpolate exposing (interpolate)


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
                    [ "Object.scalarDecoder"
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
            Debug.todo "Input objects are only for input not responses, shouldn't need decoder."
    )
        ++ (case isNullable of
                Type.Nullable ->
                    [ "Decode.nullable" ]

                Type.NonNullable ->
                    []
           )


generateEncoderLowLevel : List String -> Type.ReferrableType -> String
generateEncoderLowLevel apiSubmodule referrableType =
    generateEncoder_ True apiSubmodule (Type.TypeReference referrableType Type.NonNullable)


generateEncoder : List String -> TypeReference -> String
generateEncoder =
    generateEncoder_ False


generateEncoder_ : Bool -> List String -> TypeReference -> String
generateEncoder_ forInputObject apiSubmodule (Type.TypeReference referrableType isNullable) =
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
                    interpolate "(\\({0} raw) -> Encode.string raw)" [ constructor ] ++ isNullableString

        Type.List typeRef ->
            generateEncoder_ forInputObject apiSubmodule typeRef ++ isNullableString ++ " |> Encode.list"

        Type.ObjectRef objectName ->
            Debug.todo "I don't expect to see object references as argument types."

        Type.InterfaceRef interfaceName ->
            Debug.todo "Interfaces are never valid inputs http://facebook.github.io/graphql/October2016/#sec-Interfaces"

        Type.UnionRef _ ->
            Debug.todo "Unions are never valid inputs http://facebook.github.io/graphql/October2016/#sec-Unions"

        Type.EnumRef enumName ->
            interpolate ("(Encode.enum {0})" ++ isNullableString)
                [ ModuleName.enum { apiSubmodule = apiSubmodule } enumName
                    ++ [ "toString" ]
                    |> String.join "."
                ]

        Type.InputObjectRef inputObjectName ->
            ((if forInputObject then
                [ "encode" ++ ClassCaseName.normalized inputObjectName ]

              else
                ModuleName.inputObject { apiSubmodule = apiSubmodule } inputObjectName
                    ++ [ "encode" ++ ClassCaseName.normalized inputObjectName ]
             )
                |> String.join "."
            )
                ++ isNullableString


generateType : List String -> TypeReference -> String
generateType apiSubmodule typeRef =
    generateTypeCommon False "Maybe" apiSubmodule typeRef


generateType_ : Bool -> List String -> TypeReference -> String
generateType_ fromInputObject apiSubmodule typeRef =
    generateTypeCommon fromInputObject "Maybe" apiSubmodule typeRef


generateTypeForInputObject : List String -> TypeReference -> String
generateTypeForInputObject apiSubmodule typeRef =
    generateTypeCommon True "OptionalArgument" apiSubmodule typeRef


generateTypeCommon : Bool -> String -> List String -> TypeReference -> String
generateTypeCommon fromInputObject nullableString apiSubmodule (Type.TypeReference referrableType isNullable) =
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
            "(List " ++ generateType_ fromInputObject apiSubmodule typeRef ++ ")"

        Type.ObjectRef objectName ->
            "decodesTo"

        Type.InterfaceRef interfaceName ->
            "decodesTo"

        Type.UnionRef unionName ->
            "decodesTo"

        Type.EnumRef enumName ->
            ModuleName.enumTypeName { apiSubmodule = apiSubmodule } enumName
                |> String.join "."

        Type.InputObjectRef inputObjectName ->
            (if fromInputObject then
                [ ClassCaseName.normalized inputObjectName ]

             else
                ModuleName.inputObject { apiSubmodule = apiSubmodule } inputObjectName
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
