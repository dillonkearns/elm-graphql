module GraphqElm.Generator.Query exposing (..)

import GraphqElm.Generator.Argument
import GraphqElm.Generator.Enum
import GraphqElm.Generator.Imports
import GraphqElm.Parser.Type as Type exposing (Field, TypeDefinition, TypeReference)
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
                |> GraphqElm.Generator.Imports.importsString moduleName
    in
    interpolate
        """module {0} exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.Field as Field exposing (Field, FieldDecoder)
import GraphqElm.Object as Object exposing (Object)
import GraphqElm.TypeLock exposing (TypeLocked(TypeLocked))
import GraphqElm.Query as Query
import Json.Decode as Decode exposing (Decoder)
{1}


type Type
    = Type
"""
        [ moduleName |> String.join ".", imports ]


generateObjectOrInterface : Type.Field -> String -> String
generateObjectOrInterface field name =
    let
        ( argsAnnotation, argsList ) =
            ( GraphqElm.Generator.Argument.requiredArgsAnnotation field.args, GraphqElm.Generator.Argument.requiredArgsString field.args )
    in
    case ( argsAnnotation, argsList ) of
        ( Just annotation, Just list ) ->
            interpolate
                """{0} : {2} -> Object {0} Api.Object.{1}.Type -> Field.Query {0}
{0} requiredArgs object =
    Object.single "{0}" {3} object
        |> Query.rootQuery
"""
                [ field.name, name, annotation, list ]

        _ ->
            interpolate
                """{0} : List (TypeLocked Argument Api.Object.{1}.Type) -> Object {0} Api.Object.{1}.Type -> Field.Query {0}
{0} optionalArgs object =
    Object.single "{0}" optionalArgs object
        |> Query.rootQuery
"""
                [ field.name, name ]


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
                    """menuItems : List (TypeLocked Argument Api.Object.MenuItem.Type) -> Object menuItem Api.Object.MenuItem.Type -> Field.Query (List menuItem)
menuItems optionalArgs object =
    Object.listOf "menuItems" optionalArgs object
        |> Query.rootQuery
"""

                _ ->
                    interpolate
                        """{0} : Field.Query ({1})
{0} =
    Field.custom "{0}" ({2})
        |> Query.rootQuery
"""
                        [ field.name
                        , (if isNullable == Type.Nullable then
                            "Maybe "
                           else
                            ""
                          )
                            ++ generateType field.typeRef
                        , generateDecoderNew field.typeRef
                            ++ (if isNullable == Type.Nullable then
                                    " |> Decode.maybe"
                                else
                                    ""
                               )
                        ]


generateDecoderNew : TypeReference -> String
generateDecoderNew typeRef =
    case typeRef of
        Type.TypeReference referrableType isNullable ->
            case referrableType of
                Type.Scalar scalar ->
                    "Decode.string"

                Type.List typeRef ->
                    generateDecoderNew typeRef ++ " |> Decode.list"

                Type.ObjectRef objectName ->
                    "Api.Object." ++ objectName ++ ".decoder"

                Type.InterfaceRef interfaceName ->
                    "Api.Object." ++ interfaceName ++ ".decoder"

                Type.EnumRef enumName ->
                    GraphqElm.Generator.Enum.moduleNameFor enumName
                        ++ [ "decoder" ]
                        |> String.join "."


generateType : TypeReference -> String
generateType typeRef =
    case typeRef of
        Type.TypeReference referrableType isNullable ->
            case referrableType of
                Type.Scalar scalar ->
                    "String"

                Type.List typeRef ->
                    "(List String)"

                Type.ObjectRef objectName ->
                    "Object." ++ objectName

                Type.InterfaceRef interfaceName ->
                    "Object." ++ interfaceName

                Type.EnumRef enumName ->
                    GraphqElm.Generator.Enum.moduleNameFor enumName
                        ++ [ enumName ]
                        |> String.join "."
