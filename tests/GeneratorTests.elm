module GeneratorTests exposing (all)

import Expect
import GraphqElm.Generator.Query
import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.Type as Type exposing (TypeDefinition)
import Test exposing (..)


captainsRef : Type.Field
captainsRef =
    { name = "captains"
    , typeRef =
        Type.TypeReference
            (Type.List
                (Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable)
            )
            Type.NonNullable
    , args = []
    }


meRef : Type.Field
meRef =
    { name = "me"
    , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
    , args = []
    }


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
                        """captains : Field.Query ((List String))
captains =
    Field.custom "captains" (Decode.string |> Decode.list)
        |> Query.rootQuery
"""
        ]
