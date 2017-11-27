module GeneratorTests exposing (all)

import Expect
import GraphqElm.Generator.Query
import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.Type as Type exposing (Type)
import Test exposing (..)


all : Test
all =
    describe "generator"
        [ test "simple string" <|
            \() ->
                { name = "me", typeOf = Type.Scalar Type.NonNullable Scalar.String }
                    |> GraphqElm.Generator.Query.generate
                    |> Expect.equal
                        """me : Field.RootQuery (String)
me =
    Field.custom "me" (Decode.string)
        |> Field.rootQuery
"""
        , test "list" <|
            \() ->
                { name = "captains", typeOf = Type.List Type.NonNullable (Type.Scalar Type.NonNullable Scalar.String) }
                    |> GraphqElm.Generator.Query.generate
                    |> Expect.equal
                        """captains : Field.RootQuery (List String)
captains =
    Field.custom "captains" (Decode.string |> Decode.list)
        |> Field.rootQuery
"""
        ]
