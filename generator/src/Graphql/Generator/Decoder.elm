module Graphql.Generator.Decoder exposing (generateDecoder, generateEncoder, generateEncoderLowLevel, generateType, generateTypeForInputObject)

import Graphql.Generator.Context exposing (Context)
import Graphql.Generator.ModuleName
import Graphql.Parser.ClassCaseName as ClassCaseName
import Graphql.Parser.Scalar as Scalar
import Graphql.Parser.Type as Type exposing (TypeReference)
import ModuleName
import MyDebug
import String.Interpolate exposing (interpolate)


generateDecoder : Context -> TypeReference -> List String
generateDecoder context (Type.TypeReference referrableType isNullable) =
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
                            context.apiSubmodule
                                ++ [ "Scalar" ]
                                ++ [ ClassCaseName.normalized customScalarName ]
                                |> String.join "."
                    in
                    [ (context.scalarDecodersModule |> Maybe.withDefault (ModuleName.fromList (context.apiSubmodule ++ [ "ScalarDecoders" ])))
                        |> ModuleName.append "decoders"
                    , context.apiSubmodule
                        ++ [ "Scalar" ]
                        ++ [ "unwrapDecoders" ]
                        |> String.join "."
                    , ".decoder"
                        ++ ClassCaseName.normalized customScalarName
                    ]

        Type.List listTypeRef ->
            generateDecoder context listTypeRef ++ [ "Decode.list" ]

        Type.ObjectRef objectName ->
            [ "identity" ]

        Type.InterfaceRef interfaceName ->
            [ "identity" ]

        Type.UnionRef unionName ->
            [ "identity" ]

        Type.EnumRef enumName ->
            [ (Graphql.Generator.ModuleName.enum { apiSubmodule = context.apiSubmodule } enumName
                ++ [ "decoder" ]
              )
                |> String.join "."
            ]

        Type.InputObjectRef _ ->
            MyDebug.crash "Input objects are only for input not responses, shouldn't need decoder."
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
            MyDebug.crash "I don't expect to see object references as argument types."

        Type.InterfaceRef interfaceName ->
            MyDebug.crash "Interfaces are never valid inputs http://facebook.github.io/graphql/October2016/#sec-Interfaces"

        Type.UnionRef _ ->
            MyDebug.crash "Unions are never valid inputs http://facebook.github.io/graphql/October2016/#sec-Unions"

        Type.EnumRef enumName ->
            interpolate ("(Encode.enum {0})" ++ isNullableString)
                [ Graphql.Generator.ModuleName.enum { apiSubmodule = apiSubmodule } enumName
                    ++ [ "toString" ]
                    |> String.join "."
                ]

        Type.InputObjectRef inputObjectName ->
            ((if forInputObject then
                [ "encode" ++ ClassCaseName.normalized inputObjectName ]

              else
                Graphql.Generator.ModuleName.inputObject { apiSubmodule = apiSubmodule } inputObjectName
                    ++ [ "encode" ++ ClassCaseName.normalized inputObjectName ]
             )
                |> String.join "."
            )
                ++ isNullableString


generateType : Context -> TypeReference -> String
generateType context typeRef =
    generateTypeCommon False "Maybe" context typeRef


generateType_ : Bool -> Context -> TypeReference -> String
generateType_ fromInputObject context typeRef =
    generateTypeCommon fromInputObject "Maybe" context typeRef


generateTypeForInputObject : Context -> TypeReference -> String
generateTypeForInputObject context typeRef =
    generateTypeCommon True "OptionalArgument" context typeRef


generateTypeCommon : Bool -> String -> Context -> TypeReference -> String
generateTypeCommon fromInputObject nullableString context (Type.TypeReference referrableType isNullable) =
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
                            (context.scalarDecodersModule
                                |> Maybe.withDefault (ModuleName.fromList (context.apiSubmodule ++ [ "ScalarDecoders" ]))
                            )
                                |> ModuleName.append (ClassCaseName.normalized customScalarName)

                        {-
                                                       context.apiSubmodule
                           ++ [ "ScalarDecoders" ]
                           -- TODO ^ this could be the custom ScalarDecoder module, need to pass that as context
                           ++ [ ClassCaseName.normalized customScalarName ]
                           |> String.join "."

                        -}
                        -- BEFORE
                        --     (Object.scalarDecoder |> Decode.map Swapi.Scalar.PosixTime)
                        -- Object.selectionForField "Scalar.PosixTime" "now" []
                        --  (ScalarDecoders.decoders |> Swapi.Scalar.unwrapDecoders |> .decoderPosixTime)
                    in
                    constructor

        Type.List typeRef ->
            "(List " ++ generateType_ fromInputObject context typeRef ++ ")"

        Type.ObjectRef objectName ->
            "decodesTo"

        Type.InterfaceRef interfaceName ->
            "decodesTo"

        Type.UnionRef unionName ->
            "decodesTo"

        Type.EnumRef enumName ->
            Graphql.Generator.ModuleName.enumTypeName { apiSubmodule = context.apiSubmodule } enumName
                |> String.join "."

        Type.InputObjectRef inputObjectName ->
            (if fromInputObject then
                [ ClassCaseName.normalized inputObjectName ]

             else
                Graphql.Generator.ModuleName.inputObject { apiSubmodule = context.apiSubmodule } inputObjectName
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
