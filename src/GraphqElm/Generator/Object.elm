module GraphqElm.Generator.Object exposing (..)

import GraphqElm.Generator.Decoder
import GraphqElm.Generator.Imports as Imports
import GraphqElm.Parser.Type as Type exposing (Field, TypeDefinition, TypeReference)
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

import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.Field as Field exposing (Field, FieldDecoder)
import GraphqElm.Object as Object exposing (Object)
import Json.Decode as Decode
"""
        [ moduleName |> String.join "." ]
        ++ imports
        ++ """


type Type
    = Type


build : (a -> constructor) -> Object (a -> constructor) Type
build constructor =
    Object.object constructor
"""


generateNew : String -> Type.Field -> String
generateNew thisObjectName field =
    case field.typeRef of
        Type.TypeReference referrableType isNullable ->
            case referrableType of
                Type.ObjectRef objectName ->
                    let
                        typeLockName =
                            if thisObjectName == objectName then
                                "Type"
                            else
                                Imports.object objectName ++ [ "Type" ] |> String.join "."
                    in
                    interpolate
                        """{0} : Object {0} {1} -> Field.Query {0}
{0} object =
    Object.single "{0}" [] object
"""
                        [ field.name, typeLockName ]

                Type.InterfaceRef interfaceName ->
                    let
                        typeLockName =
                            if thisObjectName == interfaceName then
                                "Type"
                            else
                                Imports.object interfaceName ++ [ "Type" ] |> String.join "."
                    in
                    interpolate
                        """{0} : Object {0} {1} -> Field.Query {0}
{0} object =
    Object.single "{0}" [] object
"""
                        [ field.name, typeLockName ]

                Type.List (Type.TypeReference (Type.InterfaceRef objectName) isNullable) ->
                    let
                        typeLockName =
                            if thisObjectName == objectName then
                                "Type"
                            else
                                Imports.object objectName ++ [ "Type" ] |> String.join "."
                    in
                    interpolate
                        """{0} : Object {2} {1} -> FieldDecoder (List {2}) Type
{0} object =
    Object.listOf "{2}" [] object
"""
                        [ field.name, typeLockName, field.name ]

                _ ->
                    generateField field


generateField : Type.Field -> String
generateField { name, typeRef } =
    interpolate
        """{0} : FieldDecoder {1} Type
{0} =
    Field.fieldDecoder "{0}" [] ({2})
"""
        [ name
        , GraphqElm.Generator.Decoder.generateType typeRef
        , GraphqElm.Generator.Decoder.generateDecoder typeRef
        ]
