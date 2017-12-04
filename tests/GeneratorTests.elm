module GeneratorTests exposing (all)

import Expect
import Graphqelm.Generator.Query
import Graphqelm.Parser.Scalar as Scalar exposing (Scalar)
import Graphqelm.Parser.Type as Type exposing (TypeDefinition)
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
                    |> Graphqelm.Generator.Query.generateNew
                    |> Expect.equal
                        """me : Field.Query (String)
me =
    Field.fieldDecoder "me" [] (Decode.string)
        |> Query.rootQuery
"""
        , test "list" <|
            \() ->
                captainsRef
                    |> Graphqelm.Generator.Query.generateNew
                    |> Expect.equal
                        """captains : Field.Query ((List String))
captains =
    Field.fieldDecoder "captains" [] (Decode.string |> Decode.list)
        |> Query.rootQuery
"""
        ]
