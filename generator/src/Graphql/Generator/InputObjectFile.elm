module Graphql.Generator.InputObjectFile exposing (generate)

import GenerateSyntax
import Graphql.Generator.Context exposing (Context)
import Graphql.Generator.Decoder as Decoder
import Graphql.Generator.Imports as Imports
import Graphql.Generator.InputObjectFile.Constructor as Constructor
import Graphql.Generator.InputObjectFile.Details exposing (InputObjectDetails)
import Graphql.Generator.InputObjectLoops as InputObjectLoops
import Graphql.Parser.CamelCaseName as CamelCaseName exposing (CamelCaseName)
import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphql.Parser.Type as Type exposing (TypeDefinition(..))
import ModuleName
import Result.Extra
import String.Interpolate exposing (interpolate)


generate : Context -> List TypeDefinition -> Result String ( List String, String )
generate context typeDefinitions =
    generateFileContents context typeDefinitions
        |> Result.map
            (\contents ->
                ( makeModuleName context
                , contents
                )
            )


makeModuleName : Context -> List String
makeModuleName { apiSubmodule } =
    apiSubmodule ++ [ "InputObject" ]


generateFileContents : Context -> List TypeDefinition -> Result String String
generateFileContents context typeDefinitions =
    let
        typesToGenerate =
            typeDefinitions
                |> List.filterMap (isInputObject typeDefinitions)

        fields =
            typesToGenerate
                |> List.concatMap .fields

        moduleName =
            makeModuleName context |> String.join "."
    in
    if List.isEmpty typesToGenerate then
        interpolate
            """module {0} exposing (..)


placeholder : String
placeholder =
    ""
"""
            [ moduleName ]
            |> Ok

    else
        typesToGenerate
            |> List.map (generateEncoderAndAlias context)
            |> Result.Extra.combine
            |> Result.map
                (\types ->
                    interpolate
                        """module {0} exposing (..)


{1}


{2}
"""
                        [ moduleName, generateImports context fields, types |> String.join "\n\n\n" ]
                )


generateEncoderAndAlias : Context -> InputObjectDetails -> Result String String
generateEncoderAndAlias context inputObjectDetails =
    [ Constructor.generate context inputObjectDetails
    , typeAlias context inputObjectDetails
    , encoder context inputObjectDetails
    ]
        |> Result.Extra.combine
        |> Result.map (String.join "\n\n")


typeAlias : Context -> InputObjectDetails -> Result String String
typeAlias context { name, fields, hasLoop } =
    [ ClassCaseName.normalized name
    , fields
        |> List.map (aliasEntry context)
        |> Result.Extra.combine
        |> Result.map GenerateSyntax.typeAlias
    ]
        |> Result.Extra.combine
        |> Result.map
            (if hasLoop then
                interpolate """{-| Type alias for the `{0}` attributes. Note that this type
needs to use the `{0}` type (not just a plain type alias) because it has
references to itself either directly (recursive) or indirectly (circular). See
<https://github.com/dillonkearns/elm-graphql/issues/33>.
-}
type alias {0}Raw =
    {1}


{-| Type for the {0} input object.
-}
type {0}
    = {0} {0}Raw
    """

             else
                interpolate """{-| Type for the {0} input object.
-}
type alias {0} =
    {1}
    """
            )


aliasEntry : Context -> Type.Field -> Result String ( String, String )
aliasEntry context field =
    Result.map2 Tuple.pair
        (CamelCaseName.normalized field.name)
        (Decoder.generateTypeForInputObject context field.typeRef)


encoder : Context -> InputObjectDetails -> Result String String
encoder context { name, fields, hasLoop } =
    Result.map2
        (\normalized fieldEncoders ->
            let
                parameter =
                    if hasLoop then
                        interpolate "({0} input)" [ normalized ]

                    else
                        "input"
            in
            interpolate """{-| Encode a {0} into a value that can be used as an argument.
  -}
  encode{0} : {0} -> Value
  encode{0} {1} =
      Encode.maybeObject
          [ {2} ]"""
                [ normalized
                , parameter
                , fieldEncoders
                    |> String.join ", "
                ]
        )
        (ClassCaseName.normalized name)
        (fields
            |> List.map (encoderForField context)
            |> Result.Extra.combine
        )


encoderForField : Context -> Type.Field -> Result String String
encoderForField context field =
    encoderFunction context field
        |> Result.map
            (\fn ->
                interpolate """( "{0}", {1} )"""
                    [ CamelCaseName.raw field.name
                    , fn
                    ]
            )


encoderFunction : Context -> Type.Field -> Result String String
encoderFunction context field =
    case field.typeRef of
        Type.TypeReference referrableType isNullable ->
            Result.map2
                (\normalized decoder ->
                    let
                        filledOptionalsRecord_ =
                            case isNullable of
                                Type.NonNullable ->
                                    interpolate " input.{0} |> Just" [ normalized ]

                                Type.Nullable ->
                                    interpolate " |> Encode.optional input.{0}" [ normalized ]
                    in
                    interpolate "({0}) {1}"
                        [ decoder
                        , filledOptionalsRecord_
                        ]
                )
                (CamelCaseName.normalized field.name)
                (Decoder.generateEncoderLowLevel context referrableType)


generateImports : Context -> List Type.Field -> String
generateImports ({ apiSubmodule } as context) fields =
    interpolate """import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.SelectionSet exposing (SelectionSet)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import {1}.Object
import {1}.Interface
import {1}.Union
import {1}.Scalar
import {2}
import Json.Decode as Decode
import Graphql.Internal.Encode as Encode exposing (Value)
{0}
"""
        [ Imports.importsString apiSubmodule (makeModuleName context) fields
        , apiSubmodule |> String.join "."
        , context.scalarCodecsModule
            |> Maybe.withDefault (ModuleName.fromList (context.apiSubmodule ++ [ "ScalarCodecs" ]))
            |> ModuleName.toString
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
