module Graphqelm.Generator.Field exposing (generate)

import Graphqelm.Generator.Decoder
import Graphqelm.Generator.Imports as Imports
import Graphqelm.Generator.Let as Let exposing (LetBinding)
import Graphqelm.Generator.Normalize as Normalize
import Graphqelm.Generator.OptionalArgs
import Graphqelm.Generator.RequiredArgs
import Graphqelm.Generator.SpecialObjectNames exposing (SpecialObjectNames)
import Graphqelm.Parser.Type as Type exposing (TypeReference)
import Interpolate exposing (interpolate)


type alias FieldGenerator =
    { annotatedArgs : List AnnotatedArg
    , decoderAnnotation : String
    , decoder : String
    , fieldArgs : List String
    , fieldName : String
    , otherThing : String
    , letBindings : List LetBinding
    }


type alias AnnotatedArg =
    { annotation : String
    , arg : String
    }


generate : List String -> SpecialObjectNames -> String -> Type.Field -> String
generate apiSubmodule specialObjectNames thisObjectName field =
    toFieldGenerator apiSubmodule specialObjectNames field
        |> forObject_ apiSubmodule specialObjectNames thisObjectName


forObject_ : List String -> SpecialObjectNames -> String -> FieldGenerator -> String
forObject_ apiSubmodule specialObjectNames thisObjectName field =
    let
        thisObjectString =
            Imports.object apiSubmodule specialObjectNames thisObjectName |> String.join "."
    in
    fieldGeneratorToString (interpolate "FieldDecoder {0} {1}" [ field.decoderAnnotation, thisObjectString ]) field


fieldGeneratorToString : String -> FieldGenerator -> String
fieldGeneratorToString returnAnnotation field =
    let
        something =
            ((field.annotatedArgs |> List.map .annotation)
                ++ [ returnAnnotation ]
            )
                |> String.join " -> "
    in
    interpolate
        """{6} : {3}
{6} {4}={7}
      {5} "{0}" {1} ({2})
"""
        [ field.fieldName
        , field |> fieldArgsString
        , field.decoder
        , something
        , argsListString field
        , "Object" ++ field.otherThing
        , Normalize.fieldName field.fieldName
        , Let.generate field.letBindings
        ]


argsListString : { fieldGenerator | annotatedArgs : List AnnotatedArg } -> String
argsListString { annotatedArgs } =
    if annotatedArgs == [] then
        ""
    else
        (annotatedArgs |> List.map .arg |> String.join " ") ++ " "


fieldArgsString : { thing | fieldArgs : List String } -> String
fieldArgsString { fieldArgs } =
    case fieldArgs of
        [] ->
            "[]"

        [ single ] ->
            single

        _ ->
            "(" ++ String.join " ++ " fieldArgs ++ ")"


toFieldGenerator : List String -> SpecialObjectNames -> Type.Field -> FieldGenerator
toFieldGenerator apiSubmodule specialObjectNames field =
    init apiSubmodule specialObjectNames field.name field.typeRef
        |> addRequiredArgs field.args
        |> addOptionalArgs apiSubmodule field.args


addRequiredArgs : List Type.Arg -> FieldGenerator -> FieldGenerator
addRequiredArgs args fieldGenerator =
    case Graphqelm.Generator.RequiredArgs.generate args of
        Just { annotation, list } ->
            { fieldGenerator | fieldArgs = [ list ] }
                |> prependArg
                    { annotation = annotation
                    , arg = "requiredArgs"
                    }

        Nothing ->
            fieldGenerator


addOptionalArgs : List String -> List Type.Arg -> FieldGenerator -> FieldGenerator
addOptionalArgs apiSubmodule args fieldGenerator =
    case Graphqelm.Generator.OptionalArgs.generate apiSubmodule args of
        Just { annotatedArg, letBindings } ->
            { fieldGenerator
                | fieldArgs = "optionalArgs" :: fieldGenerator.fieldArgs
                , letBindings = fieldGenerator.letBindings ++ letBindings
            }
                |> prependArg annotatedArg

        Nothing ->
            fieldGenerator


objectThing : List String -> SpecialObjectNames -> String -> TypeReference -> String -> FieldGenerator
objectThing apiSubmodule specialObjectNames fieldName typeRef refName =
    let
        objectArgAnnotation =
            interpolate
                "SelectionSet {0} {1}"
                [ fieldName, Imports.object apiSubmodule specialObjectNames refName |> String.join "." ]
    in
    { annotatedArgs = []
    , fieldArgs = []
    , decoderAnnotation = fieldName
    , decoder = "object"
    , fieldName = fieldName
    , otherThing = ".single"
    , letBindings = []
    }
        |> prependArg
            { annotation = objectArgAnnotation
            , arg = "object"
            }


prependArg : AnnotatedArg -> FieldGenerator -> FieldGenerator
prependArg ({ annotation, arg } as annotatedArg) fieldGenerator =
    { fieldGenerator | annotatedArgs = annotatedArg :: fieldGenerator.annotatedArgs }


objectListThing : List String -> SpecialObjectNames -> String -> TypeReference -> String -> FieldGenerator
objectListThing apiSubmodule specialObjectNames fieldName typeRef refName =
    let
        commonObjectThing =
            objectThing apiSubmodule specialObjectNames fieldName typeRef refName
    in
    { commonObjectThing
        | decoderAnnotation = interpolate "(List {0})" [ fieldName ]
        , otherThing = ".listOf"
    }


init : List String -> SpecialObjectNames -> String -> TypeReference -> FieldGenerator
init apiSubmodule specialObjectNames fieldName ((Type.TypeReference referrableType isNullable) as typeRef) =
    case referrableType of
        Type.ObjectRef refName ->
            objectThing apiSubmodule specialObjectNames fieldName typeRef refName

        Type.InterfaceRef refName ->
            objectThing apiSubmodule specialObjectNames fieldName typeRef refName

        Type.List (Type.TypeReference (Type.InterfaceRef refName) isInterfaceNullable) ->
            objectListThing apiSubmodule specialObjectNames fieldName typeRef refName

        Type.List (Type.TypeReference (Type.ObjectRef refName) isObjectNullable) ->
            objectListThing apiSubmodule specialObjectNames fieldName typeRef refName

        _ ->
            initScalarField apiSubmodule fieldName typeRef


initScalarField : List String -> String -> TypeReference -> FieldGenerator
initScalarField apiSubmodule fieldName typeRef =
    { annotatedArgs = []
    , fieldArgs = []
    , decoderAnnotation = Graphqelm.Generator.Decoder.generateType apiSubmodule typeRef
    , decoder = Graphqelm.Generator.Decoder.generateDecoder apiSubmodule typeRef
    , fieldName = fieldName
    , otherThing = ".fieldDecoder"
    , letBindings = []
    }
