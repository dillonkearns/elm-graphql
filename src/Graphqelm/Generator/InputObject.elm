module Graphqelm.Generator.InputObject exposing (generate)

import Graphqelm.Generator.Context exposing (Context)
import Graphqelm.Generator.Decoder as Decoder
import Graphqelm.Generator.Imports as Imports
import Graphqelm.Parser.CamelCaseName as CamelCaseName exposing (CamelCaseName)
import Graphqelm.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphqelm.Parser.Type as Type
import Interpolate exposing (interpolate)


generate : Context -> ClassCaseName -> List String -> List Type.Field -> String
generate context name moduleName fields =
    [ prepend context moduleName fields
    , encoder context name fields
    , typeAlias context name fields
    ]
        |> String.join "\n\n"


typeAlias : Context -> ClassCaseName -> List Type.Field -> String
typeAlias context name fields =
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


encoder : Context -> ClassCaseName -> List Type.Field -> String
encoder context name fields =
    interpolate """{-| Encode a {0} into a value that can be used as an argument.
-}
encode : {0} -> Value
encode input =
    Encode.maybeObject
        [ {1} ]""" [ ClassCaseName.normalized name, fields |> List.map (encoderForField context) |> String.join ", " ]


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
                something =
                    case isNullable of
                        Type.NonNullable ->
                            interpolate " input.{0} |> Just" [ CamelCaseName.normalized field.name ]

                        Type.Nullable ->
                            interpolate " |> Encode.optional input.{0}" [ CamelCaseName.normalized field.name ]
            in
            interpolate "({0}) {1}"
                [ Decoder.generateEncoderLowLevel apiSubmodule referrableType
                , something
                ]


prepend : Context -> List String -> List Type.Field -> String
prepend { apiSubmodule } moduleName fields =
    interpolate """module {0} exposing (..)

import Graphqelm.Internal.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Internal.Builder.Object as Object
import Graphqelm.SelectionSet exposing (SelectionSet)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import {2}.Object
import {2}.Interface
import {2}.Union
import {2}.Scalar
import Json.Decode as Decode
import Graphqelm.Internal.Encode as Encode exposing (Value)
{1}
"""
        [ moduleName |> String.join "."
        , Imports.importsString apiSubmodule moduleName fields
        , apiSubmodule |> String.join "."
        ]
