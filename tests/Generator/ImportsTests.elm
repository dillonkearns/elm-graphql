module Generator.ImportsTests exposing (all)

import Expect
import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.Type as Type exposing (TypeDefinition, TypeReference)
import Test exposing (..)


all : Test
all =
    describe "group"
        [ test "scalar has no imports" <|
            \() ->
                imports scalarRef
                    |> Expect.equal []
        , test "list of scalars has no imports" <|
            \() ->
                imports listOfScalarRef
                    |> Expect.equal []
        ]


imports : TypeReference -> List b
imports typeRef =
    []


scalarRef : TypeReference
scalarRef =
    Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable


listOfScalarRef : TypeReference
listOfScalarRef =
    Type.TypeReference
        (Type.List scalarRef)
        Type.NonNullable
