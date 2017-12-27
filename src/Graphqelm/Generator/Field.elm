module Graphqelm.Generator.Field exposing (forMutation, forObject, forQuery)

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


forQuery : SpecialObjectNames -> Type.Field -> String
forQuery specialObjectNames field =
    toFieldGenerator specialObjectNames field
        |> forQuery_


forMutation : Type.Field -> String
forMutation field =
    toFieldGenerator { query = "", mutation = Nothing } field
        |> forMutation_


forObject : String -> Type.Field -> String
forObject thisObjectName field =
    toFieldGenerator { query = "", mutation = Nothing } field
        |> forObject_ thisObjectName


forQuery_ : FieldGenerator -> String
forQuery_ field =
    common (interpolate "FieldDecoder {0} RootQuery" [ field.decoderAnnotation ]) field


forMutation_ : FieldGenerator -> String
forMutation_ field =
    common (interpolate "FieldDecoder {0} RootMutation" [ field.decoderAnnotation ]) field


forObject_ : String -> FieldGenerator -> String
forObject_ thisObjectName field =
    let
        thisObjectString =
            Imports.object thisObjectName |> String.join "."
    in
    common (interpolate "FieldDecoder {0} {1}" [ field.decoderAnnotation, thisObjectString ]) field


common : String -> FieldGenerator -> String
common returnAnnotation field =
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


toFieldGenerator : SpecialObjectNames -> Type.Field -> FieldGenerator
toFieldGenerator specialObjectNames field =
    init specialObjectNames field.name field.typeRef
        |> addRequiredArgs field.args
        |> addOptionalArgs field.args


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


addOptionalArgs : List Type.Arg -> FieldGenerator -> FieldGenerator
addOptionalArgs args fieldGenerator =
    case Graphqelm.Generator.OptionalArgs.generate args of
        Just { annotatedArg, letBindings } ->
            { fieldGenerator
                | fieldArgs = "optionalArgs" :: fieldGenerator.fieldArgs
                , letBindings = fieldGenerator.letBindings ++ letBindings
            }
                |> prependArg annotatedArg

        Nothing ->
            fieldGenerator


objectThing : SpecialObjectNames -> String -> TypeReference -> String -> FieldGenerator
objectThing { query, mutation } fieldName typeRef refName =
    let
        objectArgAnnotation =
            interpolate
                "SelectionSet {0} {1}"
                [ fieldName, Imports.object refName |> String.join "." ]
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


objectListThing : SpecialObjectNames -> String -> TypeReference -> String -> FieldGenerator
objectListThing specialObjectNames fieldName typeRef refName =
    let
        commonObjectThing =
            objectThing specialObjectNames fieldName typeRef refName
    in
    { commonObjectThing
        | decoderAnnotation = interpolate "(List {0})" [ fieldName ]
        , otherThing = ".listOf"
    }


init : SpecialObjectNames -> String -> TypeReference -> FieldGenerator
init specialObjectNames fieldName ((Type.TypeReference referrableType isNullable) as typeRef) =
    case referrableType of
        Type.ObjectRef refName ->
            objectThing specialObjectNames fieldName typeRef refName

        Type.InterfaceRef refName ->
            objectThing specialObjectNames fieldName typeRef refName

        Type.List (Type.TypeReference (Type.InterfaceRef refName) isInterfaceNullable) ->
            objectListThing specialObjectNames fieldName typeRef refName

        Type.List (Type.TypeReference (Type.ObjectRef refName) isObjectNullable) ->
            objectListThing specialObjectNames fieldName typeRef refName

        _ ->
            initScalarField fieldName typeRef


initScalarField : String -> TypeReference -> FieldGenerator
initScalarField fieldName typeRef =
    { annotatedArgs = []
    , fieldArgs = []
    , decoderAnnotation = Graphqelm.Generator.Decoder.generateType typeRef
    , decoder = Graphqelm.Generator.Decoder.generateDecoder typeRef
    , fieldName = fieldName
    , otherThing = ".fieldDecoder"
    , letBindings = []
    }
