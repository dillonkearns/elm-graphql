module GeneratorTests exposing (all)

import Expect
import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.Type as Type exposing (Type)
import Test exposing (..)


all : Test
all =
    describe "generator"
        [ test "simple string" <|
            \() ->
                { name = "me", typeOf = Type.Scalar Type.NonNullable Scalar.String }
                    |> thing
                    |> Expect.equal
                        """me : Field.RootQuery String
me =
    Field.custom "me" Decode.string
        |> Field.rootQuery
"""
        , test "list" <|
            \() ->
                { name = "captains", typeOf = Type.List Type.NonNullable (Type.Scalar Type.NonNullable Scalar.String) }
                    |> thing
                    |> Expect.equal
                        """me : Field.RootQuery String
me =
    Field.custom "me" Decode.string
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
    """me : Field.RootQuery String
me =
    Field.custom "me" Decode.string
        |> Field.rootQuery
"""
