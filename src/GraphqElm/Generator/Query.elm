module Graphqelm.Generator.Query exposing (..)

import Graphqelm.Generator.Argument
import Graphqelm.Generator.Decoder
import Graphqelm.Generator.Imports as Imports
import Graphqelm.Parser.Type as Type exposing (Field, TypeDefinition, TypeReference)
import Interpolate exposing (interpolate)


generate : List Field -> ( List String, String )
generate fields =
    ( moduleName
    , prepend moduleName fields
        ++ (List.map generateNew fields |> String.join "\n\n")
    )


moduleName : List String
moduleName =
    [ "Api", "Query" ]


prepend : List String -> List Field -> String
prepend moduleName fields =
    let
        imports : String
        imports =
            fields
                |> List.map (\{ name, typeRef } -> typeRef)
                |> Imports.importsString moduleName
    in
    interpolate
        """module {0} exposing (..)

import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Api.Object
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Query as Query
import Json.Decode as Decode exposing (Decoder)
{1}

"""
        [ moduleName |> String.join ".", imports ]


generateObjectOrInterface : Type.Field -> String -> String
generateObjectOrInterface field name =
    let
        ( argsAnnotation, argsList ) =
            ( Graphqelm.Generator.Argument.requiredArgsAnnotation field.args, Graphqelm.Generator.Argument.requiredArgsString field.args )
    in
    case ( argsAnnotation, argsList ) of
        ( Just annotation, Just list ) ->
            interpolate
                """{0} : {2} -> Object {0} Api.Object.{1} -> Field.Query {0}
{0} requiredArgs object =
    Object.single "{0}" {3} object
        |> Query.rootQuery
"""
                [ field.name, name, annotation, list ]

        _ ->
            interpolate
                """{0} : Object {0} Api.Object.{1} -> Field.Query {0}
{0} object =
    Object.single "{0}" [] object
        |> Query.rootQuery
"""
                [ field.name, name ]


generateListOfObjectOrInterfaceRef : Type.Field -> String -> String
generateListOfObjectOrInterfaceRef field name =
    let
        typeLockName =
            Imports.object name |> String.join "."
    in
    interpolate
        """{0} : Object {0} {1} -> Field.Query (List {0})
{0} object =
    Object.listOf "{0}" [] object
        |> Query.rootQuery
  """
        [ field.name, typeLockName ]


generateNew : Type.Field -> String
generateNew field =
    case field.typeRef of
        Type.TypeReference referrableType isNullable ->
            case referrableType of
                Type.ObjectRef objectName ->
                    generateObjectOrInterface field objectName

                Type.InterfaceRef interfaceName ->
                    generateObjectOrInterface field interfaceName

                Type.List (Type.TypeReference (Type.ObjectRef objectName) isObjectNullable) ->
                    generateListOfObjectOrInterfaceRef field objectName

                Type.List (Type.TypeReference (Type.InterfaceRef interfaceName) isObjectNullable) ->
                    generateListOfObjectOrInterfaceRef field interfaceName

                _ ->
                    interpolate
                        """{0} : Field.Query ({1})
{0} =
    Field.fieldDecoder "{0}" [] ({2})
        |> Query.rootQuery
"""
                        [ field.name
                        , (if isNullable == Type.Nullable then
                            "Maybe "
                           else
                            ""
                          )
                            ++ Graphqelm.Generator.Decoder.generateType field.typeRef
                        , Graphqelm.Generator.Decoder.generateDecoder field.typeRef
                            ++ (if isNullable == Type.Nullable then
                                    " |> Decode.maybe"
                                else
                                    ""
                               )
                        ]
