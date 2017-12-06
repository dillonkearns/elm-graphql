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


toQuery : Thing -> String
toQuery ({ fieldName, useArgs, decoder, decoderAnnotation } as field) =
    interpolate
        """{0} : Field.Query ({3})
{0} =
      Field.fieldDecoder "{0}" {1} ({2})
          |> Query.rootQuery
"""
        [ fieldName, useArgs, decoder, decoderAnnotation ]


toThing : String -> Type.Field -> Thing
toThing thisObjectName field =
    let
        thisObjectString =
            Imports.object thisObjectName |> String.join "."
    in
    toThing_ thisObjectString field.name field.args field.typeRef


toThing_ : String -> String -> List Type.Arg -> TypeReference -> Thing
toThing_ thisObjectString fieldName fieldArgs (Type.TypeReference referrableType isNullable) =
    { annotationList = []
    , decoderAnnotation = "String"
    , argList = []
    , useArgs = "[]"
    , decoder = "Decode.string"
    , fieldName = fieldName
    }
