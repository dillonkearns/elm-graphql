module Generator.ImportsTests exposing (all)

import Expect
import Graphqelm.Generator.Imports as Imports
import Graphqelm.Parser.Scalar as Scalar exposing (Scalar)
import Graphqelm.Parser.Type as Type exposing (TypeDefinition, TypeReference)
import Test exposing (..)


all : Test
all =
    describe "group"
        [ test "scalar has no imports" <|
            \() ->
                Imports.imports scalarRef
                    |> Expect.equal Nothing
        , test "list of scalars has no imports" <|
            \() ->
                Imports.imports listOfScalarRef
                    |> Expect.equal Nothing
        , test "object ref has a ref" <|
            \() ->
                Imports.imports objectRef
                    |> Expect.equal (Just [ "Api", "Object", "Foo" ])
        , test "list of object ref has a ref to each" <|
            \() ->
                Imports.imports listOfObjectRef
                    |> Expect.equal (Just [ "Api", "Object", "Foo" ])
        , test "filters out its own module name" <|
            \() ->
                Imports.importsWithoutSelf [ "Api", "Object", "Foo" ] [ listOfObjectRef ]
                    |> Expect.equal []
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
