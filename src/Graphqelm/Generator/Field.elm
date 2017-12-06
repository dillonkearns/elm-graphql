module Graphqelm.Generator.Field exposing (..)

import Graphqelm.Generator.Decoder
import Graphqelm.Generator.Imports as Imports
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
    let
        something =
            (field.annotationList
                ++ [ interpolate "Field.Query {0}" [ decoderAnnotation ] ]
            )
                |> String.join " -> "
    in
    interpolate
        """{0} : {3}
{0} {4}=
      {5} "{0}" {1} ({2})
          |> Query.rootQuery
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


forObject : String -> Thing -> String
forObject thisObjectName ({ fieldName, fieldArgs, decoder, decoderAnnotation } as field) =
    let
        thisObjectString =
            Imports.object thisObjectName |> String.join "."
    in
    interpolate
        """{0} : FieldDecoder {3} {4}
{0} =
      Field.fieldDecoder "{0}" {1} ({2})
"""
        [ fieldName
        , field |> fieldArgsString
        , decoder
        , decoderAnnotation
        , thisObjectString
        ]


fieldArgsString : { thing | fieldArgs : List String } -> String
fieldArgsString { fieldArgs } =
    "[]"


toThing : Type.Field -> Thing
toThing field =
    toThing_ field.name field.args field.typeRef


toThing_ : String -> List Type.Arg -> TypeReference -> Thing
toThing_ fieldName fieldArgs ((Type.TypeReference referrableType isNullable) as typeRef) =
    emptyThing fieldName typeRef


emptyThing : String -> TypeReference -> Thing
emptyThing fieldName typeRef =
    if fieldName == "droid" then
        { annotationList = [ "Object droid Api.Object.Droid" ]
        , argList = [ "object" ]
        , fieldArgs = []
        , decoderAnnotation = "droid"
        , decoder = "object"
        , fieldName = fieldName
        , otherThing = "Object.single"
        }
    else
        { annotationList = []
        , argList = []
        , fieldArgs = []
        , decoderAnnotation = Graphqelm.Generator.Decoder.generateType typeRef
        , decoder = Graphqelm.Generator.Decoder.generateDecoder typeRef
        , fieldName = fieldName
        , otherThing = "Field.fieldDecoder"
        }
