module Graphql.Generator.Decoder exposing (generateDecoder, generateEncoder, generateEncoderLowLevel, generateType, generateTypeForInputObject)

import Graphql.Generator.Context exposing (Context)
import Graphql.Generator.ModuleName
import Graphql.Parser.ClassCaseName as ClassCaseName
import Graphql.Parser.Scalar as Scalar
import Graphql.Parser.Type as Type exposing (TypeReference)
import ModuleName
import String.Interpolate exposing (interpolate)


generateDecoder : Context -> TypeReference -> Result String (List String)
generateDecoder context (Type.TypeReference referrableType isNullable) =
    (case referrableType of
        Type.Scalar scalar ->
            case scalar of
                Scalar.String ->
                    [ "Decode.string" ]
                        |> Ok

                Scalar.Boolean ->
                    [ "Decode.bool" ]
                        |> Ok

                Scalar.Int ->
                    [ "Decode.int" ]
                        |> Ok

                Scalar.Float ->
                    [ "Decode.float" ]
                        |> Ok

                Scalar.Custom customScalarName ->
                    customScalarName
                        |> ClassCaseName.normalized
                        |> Result.map
                            (\normalized ->
                                let
                                    constructor =
                                        context.apiSubmodule
                                            ++ [ "Scalar" ]
                                            ++ [ normalized
                                               ]
                                            |> String.join "."
                                in
                                [ (context.scalarCodecsModule |> Maybe.withDefault (ModuleName.fromList (context.apiSubmodule ++ [ "ScalarCodecs" ])))
                                    |> ModuleName.append "codecs"
                                , context.apiSubmodule
                                    ++ [ "Scalar" ]
                                    ++ [ "unwrapCodecs" ]
                                    |> String.join "."
                                , ".codec"
                                    ++ normalized
                                , ".decoder"
                                ]
                            )

        Type.List listTypeRef ->
            generateDecoder context listTypeRef
                |> Result.map (\xs -> xs ++ [ "Decode.list" ])

        Type.ObjectRef objectName ->
            [ "identity" ]
                |> Ok

        Type.InterfaceRef interfaceName ->
            [ "identity" ]
                |> Ok

        Type.UnionRef unionName ->
            [ "identity" ]
                |> Ok

        Type.EnumRef enumName ->
            enumName
                |> Graphql.Generator.ModuleName.enum { apiSubmodule = context.apiSubmodule }
                |> Result.map
                    (\enums ->
                        [ (enums
                            ++ [ "decoder" ]
                          )
                            |> String.join "."
                        ]
                    )

        Type.InputObjectRef _ ->
            Err "Input objects are only for input not responses, shouldn't need decoder."
    )
        |> Result.map
            (\xs ->
                xs
                    ++ (case isNullable of
                            Type.Nullable ->
                                [ "Decode.nullable" ]

                            Type.NonNullable ->
                                []
                       )
            )


generateEncoderLowLevel : Context -> Type.ReferrableType -> Result String String
generateEncoderLowLevel context referrableType =
    generateEncoder_ context True (Type.TypeReference referrableType Type.NonNullable)


generateEncoder : Context -> TypeReference -> Result String String
generateEncoder context =
    generateEncoder_ context False


generateEncoder_ : Context -> Bool -> TypeReference -> Result String String
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
                    "Encode.string"
                        ++ isNullableString
                        |> Ok

                Scalar.Boolean ->
                    "Encode.bool"
                        ++ isNullableString
                        |> Ok

                Scalar.Int ->
                    "Encode.int"
                        ++ isNullableString
                        |> Ok

                Scalar.Float ->
                    "Encode.float"
                        ++ isNullableString
                        |> Ok

                Scalar.Custom customScalarName ->
                    let
                        constructor =
                            context.apiSubmodule
                                ++ [ "Scalar" ]
                                |> String.join "."
                    in
                    customScalarName
                        |> ClassCaseName.normalized
                        |> Result.map
                            (\normalized ->
                                interpolate "({0} |> {2}.unwrapEncoder .codec{1})"
                                    [ (context.scalarCodecsModule |> Maybe.withDefault (ModuleName.fromList (context.apiSubmodule ++ [ "ScalarCodecs" ])))
                                        |> ModuleName.append "codecs"
                                    , normalized
                                    , constructor
                                    ]
                                    ++ isNullableString
                            )

        Type.List typeRef ->
            generateEncoder_ context forInputObject typeRef
                |> Result.map
                    (\res ->
                        res
                            ++ isNullableString
                            ++ " |> Encode.list"
                    )

        Type.ObjectRef objectName ->
            Err "I don't expect to see object references as argument types."

        Type.InterfaceRef interfaceName ->
            Err "Interfaces are never valid inputs http://facebook.github.io/graphql/October2016/#sec-Interfaces"

        Type.UnionRef _ ->
            Err "Unions are never valid inputs http://facebook.github.io/graphql/October2016/#sec-Unions"

        Type.EnumRef enumName ->
            Graphql.Generator.ModuleName.enum context enumName
                |> Result.map
                    (\enums ->
                        interpolate ("(Encode.enum {0})" ++ isNullableString)
                            [ enums
                                ++ [ "toString" ]
                                |> String.join "."
                            ]
                    )

        Type.InputObjectRef inputObjectName ->
            inputObjectName
                |> ClassCaseName.normalized
                |> Result.map
                    (\normalized ->
                        ((if forInputObject then
                            [ "encode"
                                ++ normalized
                            ]

                          else
                            Graphql.Generator.ModuleName.inputObject { apiSubmodule = context.apiSubmodule } inputObjectName
                                ++ [ "encode"
                                        ++ normalized
                                   ]
                         )
                            |> String.join "."
                        )
                            ++ isNullableString
                    )


generateType : Context -> TypeReference -> Result String String
generateType context typeRef =
    generateTypeCommon False "Maybe" context typeRef


generateType_ : Bool -> Context -> TypeReference -> Result String String
generateType_ fromInputObject context typeRef =
    generateTypeCommon fromInputObject "Maybe" context typeRef


generateTypeForInputObject : Context -> TypeReference -> Result String String
generateTypeForInputObject context typeRef =
    generateTypeCommon True "OptionalArgument" context typeRef


generateTypeCommon : Bool -> String -> Context -> TypeReference -> Result String String
generateTypeCommon fromInputObject nullableString context (Type.TypeReference referrableType isNullable) =
    (case referrableType of
        Type.Scalar scalar ->
            case scalar of
                Scalar.String ->
                    "String"
                        |> Ok

                Scalar.Boolean ->
                    "Bool"
                        |> Ok

                Scalar.Int ->
                    "Int"
                        |> Ok

                Scalar.Float ->
                    "Float"
                        |> Ok

                Scalar.Custom customScalarName ->
                    ClassCaseName.normalized customScalarName
                        |> Result.map
                            (\normalized ->
                                (context.scalarCodecsModule
                                    |> Maybe.withDefault
                                        (ModuleName.fromList
                                            (context.apiSubmodule
                                                ++ [ "ScalarCodecs" ]
                                            )
                                        )
                                )
                                    |> ModuleName.append normalized
                            )

        Type.List typeRef ->
            generateType_ fromInputObject context typeRef
                |> Result.map
                    (\type_ ->
                        "(List " ++ type_ ++ ")"
                    )

        Type.ObjectRef objectName ->
            "decodesTo"
                |> Ok

        Type.InterfaceRef interfaceName ->
            "decodesTo"
                |> Ok

        Type.UnionRef unionName ->
            "decodesTo"
                |> Ok

        Type.EnumRef enumName ->
            Graphql.Generator.ModuleName.enumTypeName { apiSubmodule = context.apiSubmodule } enumName
                |> Result.map (String.join ".")

        Type.InputObjectRef inputObjectName ->
            inputObjectName
                |> ClassCaseName.normalized
                |> Result.map
                    (\normalized ->
                        (if fromInputObject then
                            [ normalized
                            ]

                         else
                            Graphql.Generator.ModuleName.inputObject { apiSubmodule = context.apiSubmodule } inputObjectName
                                ++ [ normalized
                                   ]
                        )
                            |> String.join "."
                    )
    )
        |> Result.map
            (\typeString ->
                case isNullable of
                    Type.Nullable ->
                        interpolate "({0} {1})" [ nullableString, typeString ]

                    Type.NonNullable ->
                        typeString
            )
