module Graphqelm.Generator.Field exposing (..)

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
    }


forQuery : Thing -> String
forQuery ({ fieldName, fieldArgs, decoder, decoderAnnotation } as field) =
    interpolate
        """{0} : Field.Query {3}
{0} =
      Field.fieldDecoder "{0}" {1} ({2})
          |> Query.rootQuery
"""
        [ fieldName, field |> fieldArgsString, decoder, decoderAnnotation ]


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
        [ fieldName, field |> fieldArgsString, decoder, decoderAnnotation, thisObjectString ]


fieldArgsString : { thing | fieldArgs : List String } -> String
fieldArgsString { fieldArgs } =
    "[]"


toThing : Type.Field -> Thing
toThing field =
    toThing_ field.name field.args field.typeRef


toThing_ : String -> List Type.Arg -> TypeReference -> Thing
toThing_ fieldName fieldArgs (Type.TypeReference referrableType isNullable) =
    emptyThing fieldName


emptyThing : String -> Thing
emptyThing fieldName =
    { annotationList = []
    , argList = []
    , fieldArgs = []
    , decoderAnnotation = "String"
    , decoder = "Decode.string"
    , fieldName = fieldName
    }
