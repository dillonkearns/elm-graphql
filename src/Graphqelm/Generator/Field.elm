module Graphqelm.Generator.Field exposing (forObject, forQuery)

import Graphqelm.Generator.Decoder
import Graphqelm.Generator.Imports as Imports
import Graphqelm.Generator.Normalize as Normalize
import Graphqelm.Generator.RequiredArgs
import Graphqelm.Parser.Type as Type exposing (Field, TypeDefinition, TypeReference)
import Interpolate exposing (interpolate)


type alias FieldGenerator =
    { annotationList : List String
    , decoderAnnotation : String
    , argList : List String
    , decoder : String
    , fieldArgs : List String
    , fieldName : String
    , otherThing : String
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
forQuery_ ({ fieldName, fieldArgs, decoder, decoderAnnotation, argList, otherThing } as field) =
    common (interpolate "Field.Query {0}" [ decoderAnnotation ]) field
        ++ "          |> Query.rootQuery\n"


forObject_ : String -> FieldGenerator -> String
forObject_ thisObjectName field =
    let
        thisObjectString =
            Imports.object thisObjectName |> String.join "."
    in
    common (interpolate "FieldDecoder {0} {1}" [ field.decoderAnnotation, thisObjectString ]) field


common : String -> FieldGenerator -> String
common returnAnnotation ({ fieldName, fieldArgs, decoder, decoderAnnotation, argList, otherThing } as field) =
    let
        something =
            (field.annotationList
                ++ [ returnAnnotation ]
            )
                |> String.join " -> "
    in
    interpolate
        """{6} : {3}
{6} {4}=
      {5} "{0}" {1} ({2})
"""
        [ fieldName
        , field |> fieldArgsString
        , decoder
        , something
        , argsListString field
        , otherThing
        , Normalize.fieldName fieldName
        ]


argsListString : { thing | argList : List String } -> String
argsListString { argList } =
    if argList == [] then
        ""
    else
        (argList |> String.join " ") ++ " "


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


addRequiredArgs : List Type.Arg -> FieldGenerator -> FieldGenerator
addRequiredArgs args thing =
    case Graphqelm.Generator.RequiredArgs.generate args of
        Just { annotation, list } ->
            { thing
                | argList = "requiredArgs" :: thing.argList
                , annotationList = annotation :: thing.annotationList
                , fieldArgs = [ list ]
            }

        Nothing ->
            thing


objectThing : String -> TypeReference -> String -> FieldGenerator
objectThing fieldName typeRef refName =
    let
        objectArgAnnotation =
            interpolate
                "Object {0} {1}"
                [ fieldName, Imports.object refName |> String.join "." ]
    in
    { annotationList = [ objectArgAnnotation ]
    , argList = [ "object" ]
    , fieldArgs = []
    , decoderAnnotation = fieldName
    , decoder = "object"
    , fieldName = fieldName
    , otherThing = "Object.single"
    }


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
    { annotationList = []
    , argList = []
    , fieldArgs = []
    , decoderAnnotation = Graphqelm.Generator.Decoder.generateType typeRef
    , decoder = Graphqelm.Generator.Decoder.generateDecoder typeRef
    , fieldName = fieldName
    , otherThing = "Field.fieldDecoder"
    }
