module GeneratorTests exposing (all)

import Expect
import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.Type as Type exposing (Type)
import String.Format
import Test exposing (..)


all : Test
all =
    describe "generator"
        [ test "simple string" <|
            \() ->
                { name = "me", typeOf = Type.Scalar Type.NonNullable Scalar.String }
                    |> thing
                    |> Expect.equal
                        """me : Field.RootQuery (String)
me =
    Field.custom "me" (Decode.string)
        |> Field.rootQuery
"""
        , test "list" <|
            \() ->
                { name = "captains", typeOf = Type.List Type.NonNullable (Type.Scalar Type.NonNullable Scalar.String) }
                    |> thing
                    |> Expect.equal
                        """captains : Field.RootQuery (List String)
captains =
    Field.custom "captains" (Decode.string |> Decode.list)
        |> Field.rootQuery
"""
        ]


thing : { name : String, typeOf : Type } -> String
thing something =
    generate something


prepend : String
prepend =
    """module Schema.Query exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.Field as Field exposing (Field, FieldDecoder)
import GraphqElm.Object as Object exposing (Object)
import GraphqElm.TypeLock exposing (TypeLocked(TypeLocked))
import Json.Decode as Decode exposing (Decoder)


"""


generate : { name : String, typeOf : Type } -> String
generate { name, typeOf } =
    String.Format.format3
        """{1} : Field.RootQuery ({2})
{1} =
    Field.custom "{1}" ({3})
        |> Field.rootQuery
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


generateType : Type -> String
generateType typeOf =
    case typeOf of
        Type.List Type.NonNullable (Type.Scalar Type.NonNullable Scalar.String) ->
            "List String"

        Type.Scalar isNullable scalar ->
            "String"

        Type.List isNullable type_ ->
            "List String"
