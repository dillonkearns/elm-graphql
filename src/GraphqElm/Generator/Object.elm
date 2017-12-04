module Graphqelm.Generator.Object exposing (..)

import Graphqelm.Generator.Decoder
import Graphqelm.Generator.Imports as Imports
import Graphqelm.Parser.Type as Type exposing (Field, TypeDefinition, TypeReference)
import Interpolate exposing (interpolate)


generate : String -> List Type.Field -> ( List String, String )
generate name fields =
    ( Imports.object name
    , prepend (Imports.object name) fields
        ++ (List.map (generateNew name) fields |> String.join "\n\n")
    )


prepend : List String -> List Type.Field -> String
prepend moduleName fields =
    let
        imports : String
        imports =
            fields
                |> List.map (\{ name, typeRef } -> typeRef)
                |> Imports.importsString moduleName
    in
    interpolate """module {0} exposing (..)

import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Api.Object
import Json.Decode as Decode
{1}


build : (a -> constructor) -> Object (a -> constructor) {0}
build constructor =
    Object.object constructor
"""
        [ moduleName |> String.join ".", imports ]


generateNew : String -> Type.Field -> String
generateNew thisObjectName field =
    let
        thisObjectString =
            Imports.object thisObjectName |> String.join "."
    in
    case field.typeRef of
        Type.TypeReference referrableType isNullable ->
            case referrableType of
                Type.ObjectRef objectName ->
                    let
                        typeLockName =
                            Imports.object objectName |> String.join "."
                    in
                    interpolate
                        """{0} : Object {0} {1} -> Field.Query {0} {2}
{0} object =
    Object.single "{0}" [] object
"""
                        [ field.name, typeLockName, thisObjectString ]

                Type.InterfaceRef interfaceName ->
                    let
                        typeLockName =
                            Imports.object interfaceName |> String.join "."
                    in
                    interpolate
                        """{0} : Object {0} {1} -> Field.Query {0} {2}
{0} object =
    Object.single "{0}" [] object
"""
                        [ field.name, typeLockName, thisObjectString ]

                Type.List (Type.TypeReference (Type.InterfaceRef objectName) isNullable) ->
                    let
                        typeLockName =
                            Imports.object objectName |> String.join "."
                    in
                    interpolate
                        """{0} : Object {2} {1} -> FieldDecoder (List {2}) {3}
{0} object =
    Object.listOf "{2}" [] object
"""
                        [ field.name, typeLockName, field.name, thisObjectString ]

                _ ->
                    generateField thisObjectString field


generateField : String -> Type.Field -> String
generateField thisObjectString { name, typeRef } =
    interpolate
        """{0} : FieldDecoder {1} {3}
{0} =
    Field.fieldDecoder "{0}" [] ({2})
"""
        [ name
        , Graphqelm.Generator.Decoder.generateType typeRef
        , Graphqelm.Generator.Decoder.generateDecoder typeRef
        , thisObjectString
        ]
