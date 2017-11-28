module GraphqElm.Generator.Query exposing (..)

import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.Type as Type exposing (Type)
import String.Format


generate : { name : String, typeOf : Type } -> String
generate { name, typeOf } =
    String.Format.format3
        """{1} : Field.Query ({2})
{1} =
    Field.custom "{1}" ({3})
        |> Query.rootQuery
"""
        ( name, generateType typeOf, generateDecoder typeOf )


generateDecoder : Type -> String
generateDecoder typeOf =
    case typeOf of
        Type.List Type.NonNullable (Type.Scalar Type.NonNullable Scalar.String) ->
            "Decode.string |> Decode.list"

        Type.Scalar isNullable scalar ->
            "Decode.string"

        Type.List isNullable type_ ->
            "Decode.string |> Decode.list"

        Type.Object _ _ ->
            Debug.crash "TODO"


generateType : Type -> String
generateType typeOf =
    case typeOf of
        Type.List Type.NonNullable (Type.Scalar Type.NonNullable Scalar.String) ->
            "List String"

        Type.Scalar isNullable scalar ->
            "String"

        Type.List isNullable type_ ->
            "List String"

        Type.Object _ _ ->
            Debug.crash "TODO"
