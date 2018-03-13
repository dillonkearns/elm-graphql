module Graphqelm.Generator.InputObjectFile exposing (generate)

import Graphqelm.Generator.Context exposing (Context)
import Graphqelm.Generator.Decoder as Decoder
import Graphqelm.Generator.Imports as Imports
import Graphqelm.Generator.InputObjectFile.Constructor as Constructor
import Graphqelm.Generator.InputObjectFile.Details exposing (InputObjectDetails)
import Graphqelm.Generator.InputObjectLoops as InputObjectLoops
import Graphqelm.Parser.CamelCaseName as CamelCaseName exposing (CamelCaseName)
import Graphqelm.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphqelm.Parser.Type as Type exposing (TypeDefinition(TypeDefinition))
import String.Interpolate exposing (interpolate)


generate : Context -> List TypeDefinition -> ( List String, String )
generate context typeDefinitions =
    ( moduleName context
    , generateFileContents context typeDefinitions
    )


moduleName : Context -> List String
moduleName { apiSubmodule } =
    apiSubmodule ++ [ "InputObject" ]


generateFileContents : Context -> List TypeDefinition -> String
generateFileContents context typeDefinitions =
    let
        typesToGenerate =
            typeDefinitions
                |> List.filterMap (isInputObject typeDefinitions)

        fields =
            typesToGenerate
                |> List.concatMap .fields
    in
    if typesToGenerate == [] then
        interpolate
            """module {0} exposing (..)


placeholder : String
placeholder =
    ""
"""
            [ moduleName context |> String.join "." ]
    else
        interpolate
            """module {0} exposing (..)


{1}


{2}
"""
            [ moduleName context |> String.join "."
            , generateImports context fields
            , typesToGenerate
                |> List.map (generateEncoderAndAlias context)
                |> String.join "\n\n\n"
            ]


generateEncoderAndAlias : Context -> InputObjectDetails -> String
generateEncoderAndAlias context inputObjectDetails =
    [ Constructor.generate context inputObjectDetails
    , typeAlias context inputObjectDetails
    , encoder context inputObjectDetails
    ]
        |> String.join "\n\n"


filledOptionalsRecord : List Type.Field -> String
filledOptionalsRecord optionalFields =
    optionalFields
        |> List.map .name
        |> List.map (\fieldName -> CamelCaseName.normalized fieldName ++ " = Absent")
        |> String.join ", "


typeAlias : Context -> InputObjectDetails -> String
typeAlias context { name, fields, hasLoop } =
    if hasLoop then
        interpolate """{-| Type alias for the `{0}` attributes. Note that this type
needs to use the `{0}` type (not just a plain type alias) because it has
references to itself either directly (recursive) or indirectly (circular). See
<https://github.com/dillonkearns/graphqelm/issues/33>.
-}
type alias {0}Raw =
    { {1} }


{-| Type for the {0} input object.
-}
type {0}
    = {0} {0}Raw
    """
            [ ClassCaseName.normalized name
            , List.map (aliasEntry context) fields |> String.join ", "
            ]
    else
        interpolate """{-| Type for the {0} input object.
-}
type alias {0} =
    { {1} }
    """
            [ ClassCaseName.normalized name
            , List.map (aliasEntry context) fields |> String.join ", "
            ]


aliasEntry : Context -> Type.Field -> String
aliasEntry { apiSubmodule } field =
    interpolate "{0} : {1}"
        [ CamelCaseName.normalized field.name
        , Decoder.generateTypeForInputObject apiSubmodule field.typeRef
        ]


encoder : Context -> InputObjectDetails -> String
encoder context { name, fields, hasLoop } =
    let
        parameter =
            if hasLoop then
                interpolate "({0} input)" [ ClassCaseName.normalized name ]
            else
                "input"
    in
    interpolate """{-| Encode a {0} into a value that can be used as an argument.
-}
encode{0} : {0} -> Value
encode{0} {1} =
    Encode.maybeObject
        [ {2} ]"""
        [ ClassCaseName.normalized name
        , parameter
        , fields |> List.map (encoderForField context) |> String.join ", "
        ]


encoderForField : Context -> Type.Field -> String
encoderForField context field =
    interpolate """( "{0}", {1} )"""
        [ CamelCaseName.normalized field.name
        , encoderFunction context field
        ]


encoderFunction : Context -> Type.Field -> String
encoderFunction { apiSubmodule } field =
    case field.typeRef of
        Type.TypeReference referrableType isNullable ->
            let
                filledOptionalsRecord =
                    case isNullable of
                        Type.NonNullable ->
                            interpolate " input.{0} |> Just" [ CamelCaseName.normalized field.name ]

                        Type.Nullable ->
                            interpolate " |> Encode.optional input.{0}" [ CamelCaseName.normalized field.name ]
            in
            interpolate "({0}) {1}"
                [ Decoder.generateEncoderLowLevel apiSubmodule referrableType
                , filledOptionalsRecord
                ]


generateImports : Context -> List Type.Field -> String
generateImports ({ apiSubmodule } as context) fields =
    interpolate """import Graphqelm.Internal.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Internal.Builder.Object as Object
import Graphqelm.SelectionSet exposing (SelectionSet)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import {1}.Object
import {1}.Interface
import {1}.Union
import {1}.Scalar
import Json.Decode as Decode
import Graphqelm.Internal.Encode as Encode exposing (Value)
{0}
"""
        [ Imports.importsString apiSubmodule (moduleName context) fields
        , apiSubmodule |> String.join "."
        ]


isInputObject : List TypeDefinition -> TypeDefinition -> Maybe InputObjectDetails
isInputObject typeDefs ((TypeDefinition name definableType description) as typeDef) =
    case definableType of
        Type.InputObjectType fields ->
            Just
                { name = name
                , definableType = definableType
                , fields = fields
                , hasLoop = typeDef |> InputObjectLoops.hasLoop typeDefs
                }

        _ ->
            Nothing
