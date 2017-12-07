module Graphqelm.Generator.Field exposing (forObject, forQuery, toThing)

import Graphqelm.Generator.Decoder
import Graphqelm.Generator.Imports as Imports
import Graphqelm.Generator.RequiredArgs
import Graphqelm.Parser.Type as Type exposing (Field, TypeDefinition, TypeReference)
import Interpolate exposing (interpolate)


type alias Thing =
    { annotationList : List String
    , decoderAnnotation : String
    , argList : List String
    , decoder : String
    , fieldArgs : List String
    , fieldName : String
    , otherThing : String
    }


forQuery : Thing -> String
forQuery ({ fieldName, fieldArgs, decoder, decoderAnnotation, argList, otherThing } as field) =
    common (interpolate "Field.Query {0}" [ decoderAnnotation ]) field
        ++ "          |> Query.rootQuery\n"


forObject : String -> Thing -> String
forObject thisObjectName field =
    let
        thisObjectString =
            Imports.object thisObjectName |> String.join "."
    in
    common (interpolate "FieldDecoder {0} {1}" [ field.decoderAnnotation, thisObjectString ]) field


common : String -> Thing -> String
common returnAnnotation ({ fieldName, fieldArgs, decoder, decoderAnnotation, argList, otherThing } as field) =
    let
        something =
            (field.annotationList
                ++ [ returnAnnotation ]
            )
                |> String.join " -> "
    in
    interpolate
        """{0} : {3}
{0} {4}=
      {5} "{0}" {1} ({2})
"""
        [ fieldName
        , field |> fieldArgsString
        , decoder
        , something
        , argsListString field
        , otherThing
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
            "TODO"


toThing : Type.Field -> Thing
toThing field =
    toThing_ field.name field.args field.typeRef
        |> addRequiredArgs field.args


toThing_ : String -> List Type.Arg -> TypeReference -> Thing
toThing_ fieldName fieldArgs ((Type.TypeReference referrableType isNullable) as typeRef) =
    init fieldName typeRef


addRequiredArgs : List Type.Arg -> Thing -> Thing
addRequiredArgs args thing =
    case Graphqelm.Generator.RequiredArgs.generate args of
        Just { annotation, list } ->
            { thing
                | argList = "requiredArgs" :: thing.argList
                , annotationList = "{ id : String }" :: thing.annotationList
                , fieldArgs = [ """[ Argument.string "id" requiredArgs.id ]""" ]
            }

        Nothing ->
            thing


objectThing : String -> TypeReference -> String -> Thing
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


objectListThing : String -> TypeReference -> String -> Thing
objectListThing fieldName typeRef refName =
    let
        commonObjectThing =
            objectThing fieldName typeRef refName
    in
    { commonObjectThing
        | decoderAnnotation = interpolate "(List {0})" [ fieldName ]
        , otherThing = "Object.listOf"
    }


init : String -> TypeReference -> Thing
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
            { annotationList = []
            , argList = []
            , fieldArgs = []
            , decoderAnnotation = Graphqelm.Generator.Decoder.generateType typeRef
            , decoder = Graphqelm.Generator.Decoder.generateDecoder typeRef
            , fieldName = fieldName
            , otherThing = "Field.fieldDecoder"
            }
