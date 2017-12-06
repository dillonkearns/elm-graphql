module Graphqelm.Generator.Field exposing (..)

import Graphqelm.Generator.Imports as Imports
import Graphqelm.Parser.Type as Type exposing (Field, TypeDefinition, TypeReference)
import Interpolate exposing (interpolate)


type alias Thing =
    { annotationList : List String
    , decoderAnnotation : String
    , argList : List String
    , decoder : String
    , useArgs : String
    , fieldName : String
    }


forQuery : Thing -> String
forQuery ({ fieldName, useArgs, decoder, decoderAnnotation } as field) =
    interpolate
        """{0} : Field.Query {3}
{0} =
      Field.fieldDecoder "{0}" {1} ({2})
          |> Query.rootQuery
"""
        [ fieldName, useArgs, decoder, decoderAnnotation ]


forObject : String -> Thing -> String
forObject thisObjectName ({ fieldName, useArgs, decoder, decoderAnnotation } as field) =
    let
        thisObjectString =
            Imports.object thisObjectName |> String.join "."
    in
    interpolate
        """{0} : FieldDecoder {3} {4}
{0} =
      Field.fieldDecoder "{0}" {1} ({2})
"""
        [ fieldName, useArgs, decoder, decoderAnnotation, thisObjectString ]


toThing : Type.Field -> Thing
toThing field =
    toThing_ field.name field.args field.typeRef


toThing_ : String -> List Type.Arg -> TypeReference -> Thing
toThing_ fieldName fieldArgs (Type.TypeReference referrableType isNullable) =
    { annotationList = []
    , decoderAnnotation = "String"
    , argList = []
    , useArgs = "[]"
    , decoder = "Decode.string"
    , fieldName = fieldName
    }
