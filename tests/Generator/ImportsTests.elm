module Generator.ImportsTests exposing (all)

import Expect
import GraphqElm.Generator.Imports as Imports
import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.Type as Type exposing (TypeDefinition, TypeReference)
import Test exposing (..)


all : Test
all =
    describe "group"
        [ test "scalar has no imports" <|
            \() ->
                Imports.imports scalarRef
                    |> Expect.equal []
        , test "list of scalars has no imports" <|
            \() ->
                Imports.imports listOfScalarRef
                    |> Expect.equal []
        , test "object ref has a ref" <|
            \() ->
                Imports.imports objectRef
                    |> Expect.equal [ "Foo" ]
        , test "list of object ref has a ref to each" <|
            \() ->
                Imports.imports listOfObjectRef
                    |> Expect.equal [ "Foo" ]
        ]


scalarRef : TypeReference
scalarRef =
    Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable


objectRef : TypeReference
objectRef =
    Type.TypeReference (Type.ObjectRef "Foo") Type.NonNullable


listOfScalarRef : TypeReference
listOfScalarRef =
    Type.TypeReference
        (Type.List scalarRef)
        Type.NonNullable


listOfObjectRef : TypeReference
listOfObjectRef =
    Type.TypeReference
        (Type.List objectRef)
        Type.NonNullable
