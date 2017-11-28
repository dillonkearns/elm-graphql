module GeneratorTests exposing (all)

import Expect
import GraphqElm.Generator.Query
import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.TypeNew as TypeNew exposing (TypeDefinition)
import Test exposing (..)


captainsRef : TypeNew.Field
captainsRef =
    { name = "captains"
    , typeRef =
        TypeNew.TypeReference
            (TypeNew.List
                (TypeNew.TypeReference (TypeNew.Scalar Scalar.String) TypeNew.NonNullable)
            )
            TypeNew.Nullable
    }


meRef : TypeNew.Field
meRef =
    { name = "me", typeRef = TypeNew.TypeReference (TypeNew.Scalar Scalar.String) TypeNew.NonNullable }


all : Test
all =
    describe "generator"
        [ test "simple string" <|
            \() ->
                meRef
                    |> GraphqElm.Generator.Query.generateNew
                    |> Expect.equal
                        """me : Field.Query (String)
me =
    Field.custom "me" (Decode.string)
        |> Query.rootQuery
"""
        , test "list" <|
            \() ->
                captainsRef
                    |> GraphqElm.Generator.Query.generateNew
                    |> Expect.equal
                        """captains : Field.Query (List String)
captains =
    Field.custom "captains" (Decode.string |> Decode.list)
        |> Query.rootQuery
"""
        ]
