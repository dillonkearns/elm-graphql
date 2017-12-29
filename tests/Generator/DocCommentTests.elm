module Generator.DocCommentTests exposing (all)

import Expect
import Graphqelm.Generator.DocComment as DocComment
import Graphqelm.Parser.Scalar as Scalar exposing (Scalar)
import Graphqelm.Parser.Type as Type exposing (TypeDefinition, TypeReference)
import Test exposing (Test, describe, test)


all : Test
all =
    describe "doc comment generator"
        [ test "field with no args" <|
            \() ->
                { name = "human"
                , description = Just "A human in the star wars universe."
                , typeRef = Type.TypeReference (Type.InterfaceRef "Human") Type.NonNullable
                , args = []
                }
                    |> DocComment.generate
                    |> Expect.equal """{-| A human in the star wars universe.
-}
"""
        ]
