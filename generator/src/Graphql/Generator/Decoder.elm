module Graphql.Generator.Decoder exposing (generateDecoder, generateEncoder, generateEncoderLowLevel, generateType, generateTypeForInputObject)

import Elm.Annotation
import Elm.ToString
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
                    [ (context.scalarCodecsModule |> Maybe.withDefault (ModuleName.fromList (context.apiSubmodule ++ [ "ScalarCodecs" ])))
                        |> ModuleName.append "codecs"
                    , context.apiSubmodule
                        ++ [ "Scalar" ]
                        ++ [ "unwrapCodecs" ]
                        |> String.join "."
                    , ".codec"
                        ++ ClassCaseName.normalized customScalarName
                    , ".decoder"
                    ]

        Type.List listTypeRef ->
            generateDecoder context listTypeRef ++ [ "Decode.list" ]

        Type.ObjectRef objectName ->
            [ "Basics.identity" ]

        Type.InterfaceRef interfaceName ->
            [ "Basics.identity" ]

        Type.UnionRef unionName ->
            [ "Basics.identity" ]

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


generateEncoderLowLevel : Context -> Type.ReferrableType -> String
generateEncoderLowLevel context referrableType =
    generateEncoder_ context True (Type.TypeReference referrableType Type.NonNullable)


generateEncoder : Context -> TypeReference -> String
generateEncoder context =
    generateEncoder_ context False


generateEncoder_ : Context -> Bool -> TypeReference -> String
generateEncoder_ context forInputObject (Type.TypeReference referrableType isNullable) =
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
                            context.apiSubmodule
                                ++ [ "Scalar" ]
                                |> String.join "."
                    in
                    interpolate "({0} |> {2}.unwrapEncoder .codec{1})"
                        [ (context.scalarCodecsModule |> Maybe.withDefault (ModuleName.fromList (context.apiSubmodule ++ [ "ScalarCodecs" ])))
                            |> ModuleName.append "codecs"
                        , ClassCaseName.normalized customScalarName
                        , constructor
                        ]
                        ++ isNullableString

        Type.List typeRef ->
            generateEncoder_ context forInputObject typeRef ++ " |> Encode.list" ++ isNullableString

        Type.ObjectRef objectName ->
            MyDebug.crash "I don't expect to see object references as argument types."

        Type.InterfaceRef interfaceName ->
            MyDebug.crash "Interfaces are never valid inputs https://spec.graphql.org/October2016/#sec-Interfaces"

        Type.UnionRef _ ->
            MyDebug.crash "Unions are never valid inputs https://spec.graphql.org/October2016/#sec-Unions"

        Type.EnumRef enumName ->
            interpolate ("(Encode.enum {0})" ++ isNullableString)
                [ Graphql.Generator.ModuleName.enum context enumName
                    ++ [ "toString" ]
                    |> String.join "."
                ]

        Type.InputObjectRef inputObjectName ->
            ((if forInputObject then
                [ "encode" ++ ClassCaseName.normalized inputObjectName ]

              else
                Graphql.Generator.ModuleName.inputObject { apiSubmodule = context.apiSubmodule } inputObjectName
                    ++ [ "encode" ++ ClassCaseName.normalized inputObjectName ]
             )
                |> String.join "."
            )
                ++ isNullableString


generateType : Context -> TypeReference -> String
generateType context typeRef =
    generateTypeCommon False "Maybe" context typeRef
        |> toStringWithParens


generateType_ : Bool -> Context -> TypeReference -> String
generateType_ fromInputObject context typeRef =
    generateTypeCommon fromInputObject "Maybe" context typeRef
        |> toStringWithParens


generateTypeForInputObject : Context -> TypeReference -> String
generateTypeForInputObject context typeRef =
    generateTypeCommon True "OptionalArgument" context typeRef
        |> toStringWithParens


generateTypeCommon : Bool -> String -> Context -> TypeReference -> Elm.Annotation.Annotation
generateTypeCommon fromInputObject nullableString context (Type.TypeReference referrableType isNullable) =
    (case referrableType of
        Type.Scalar scalar ->
            Scalar.toAnnotation context scalar

        Type.List typeRef ->
            -- TODO remove hacked type from String
            Elm.Annotation.var ("(List " ++ generateType_ fromInputObject context typeRef ++ ")")

        Type.ObjectRef objectName ->
            Elm.Annotation.var "decodesTo"

        Type.InterfaceRef interfaceName ->
            Elm.Annotation.var "decodesTo"

        Type.UnionRef unionName ->
            Elm.Annotation.var "decodesTo"

        Type.EnumRef enumName ->
            Graphql.Generator.ModuleName.enumTypeName { apiSubmodule = context.apiSubmodule } enumName

        Type.InputObjectRef inputObjectName ->
            let
                namespace : List String
                namespace =
                    if fromInputObject then
                        []

                    else
                        Graphql.Generator.ModuleName.inputObject { apiSubmodule = context.apiSubmodule } inputObjectName
            in
            Elm.Annotation.named namespace (ClassCaseName.normalized inputObjectName)
    )
        |> (\typeString ->
                case isNullable of
                    Type.Nullable ->
                        Elm.Annotation.namedWith [] nullableString [ typeString ]

                    Type.NonNullable ->
                        typeString
           )


toStringWithParens : Elm.Annotation.Annotation -> String
toStringWithParens annotation =
    "("
        ++ Elm.Annotation.toString annotation
        ++ ")"
