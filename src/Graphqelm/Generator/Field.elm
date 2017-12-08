module Graphqelm.Generator.Field exposing (forObject, forQuery)

import Graphqelm.Generator.Decoder
import Graphqelm.Generator.Imports as Imports
import Graphqelm.Generator.Normalize as Normalize
import Graphqelm.Generator.OptionalArgs
import Graphqelm.Generator.RequiredArgs
import Graphqelm.Parser.Type as Type exposing (Field, TypeDefinition, TypeReference)
import Interpolate exposing (interpolate)


type alias FieldGenerator =
    { annotatedArgs : List AnnotatedArg
    , decoderAnnotation : String
    , decoder : String
    , fieldArgs : List String
    , fieldName : String
    , otherThing : String
    , letBindings : List ( String, String )
    }


type alias AnnotatedArg =
    { annotation : String
    , arg : String
    }


forQuery : Type.Field -> String
forQuery field =
    toFieldGenerator field
        |> forQuery_


forObject : String -> Type.Field -> String
forObject thisObjectName field =
    toFieldGenerator field
        |> forObject_ thisObjectName


forQuery_ : FieldGenerator -> String
forQuery_ field =
    common (interpolate "Field.Query {0}" [ field.decoderAnnotation ]) field
        ++ "          |> Query.rootQuery\n"


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
        , field.otherThing
        , Normalize.fieldName field.fieldName
        , letBindingsString field
        ]


letBindingsString : { fieldGenerator | letBindings : List ( String, String ) } -> String
letBindingsString { letBindings } =
    let
        letString =
            [ """        filledInOptionals =
            fillInOptionals { contains = Nothing }"""
            , """        optionalArgs =
            [ Argument.optional "contains" filledInOptionals.contains Encode.string ]
                |> List.filterMap identity"""
            ]
                |> String.join "\n\n"
    in
    if letBindings == [] then
        ""
    else
        interpolate
            """
    let
{0}
    in"""
            [ letString ]


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
            Debug.crash "TODO"


toFieldGenerator : Type.Field -> FieldGenerator
toFieldGenerator field =
    init field.name field.typeRef
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


objectThing : String -> TypeReference -> String -> FieldGenerator
objectThing fieldName typeRef refName =
    let
        objectArgAnnotation =
            interpolate
                "Object {0} {1}"
                [ fieldName, Imports.object refName |> String.join "." ]
    in
    { annotatedArgs = []
    , fieldArgs = []
    , decoderAnnotation = fieldName
    , decoder = "object"
    , fieldName = fieldName
    , otherThing = "Object.single"
    , letBindings = []
    }
        |> prependArg
            { annotation = objectArgAnnotation
            , arg = "object"
            }


prependArg : AnnotatedArg -> FieldGenerator -> FieldGenerator
prependArg ({ annotation, arg } as annotatedArg) fieldGenerator =
    { fieldGenerator | annotatedArgs = annotatedArg :: fieldGenerator.annotatedArgs }


objectListThing : String -> TypeReference -> String -> FieldGenerator
objectListThing fieldName typeRef refName =
    let
        commonObjectThing =
            objectThing fieldName typeRef refName
    in
    { commonObjectThing
        | decoderAnnotation = interpolate "(List {0})" [ fieldName ]
        , otherThing = "Object.listOf"
    }


init : String -> TypeReference -> FieldGenerator
init fieldName ((Type.TypeReference referrableType isNullable) as typeRef) =
    case referrableType of
        Type.ObjectRef refName ->
            objectThing fieldName typeRef refName

        Type.InterfaceRef refName ->
            objectThing fieldName typeRef refName

        Type.List (Type.TypeReference (Type.InterfaceRef refName) isInterfaceNullable) ->
            objectListThing fieldName typeRef refName

        Type.List (Type.TypeReference (Type.ObjectRef refName) isObjectNullable) ->
            objectListThing fieldName typeRef refName

        _ ->
            initScalarField fieldName typeRef


initScalarField : String -> TypeReference -> FieldGenerator
initScalarField fieldName typeRef =
    { annotatedArgs = []
    , fieldArgs = []
    , decoderAnnotation = Graphqelm.Generator.Decoder.generateType typeRef
    , decoder = Graphqelm.Generator.Decoder.generateDecoder typeRef
    , fieldName = fieldName
    , otherThing = "Field.fieldDecoder"
    , letBindings = []
    }
