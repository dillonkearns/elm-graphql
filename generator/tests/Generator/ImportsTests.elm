module Generator.ImportsTests exposing (all)

import Expect
import Graphql.Generator.Imports as Imports
import Graphql.Parser.ClassCaseName as ClassCaseName
import Graphql.Parser.Scalar as Scalar exposing (Scalar)
import Graphql.Parser.Type as Type exposing (TypeDefinition, TypeReference)
import Test exposing (..)


all : Test
all =
    describe "group"
        [ test "scalar has no imports" <|
            \() ->
                Imports.imports [ "Api" ] scalarRef
                    |> Expect.equal Nothing
        , test "list of scalars has no imports" <|
            \() ->
                Imports.imports [ "Api" ] listOfScalarRef
                    |> Expect.equal Nothing
        , test "object refs don't need imports" <|
            \() ->
                Imports.imports [ "Api" ] objectRef
                    |> Expect.equal Nothing
        , test "list of object ref don't need imports" <|
            \() ->
                Imports.imports [ "Api" ] listOfObjectRef
                    |> Expect.equal Nothing
        , test "enum ref needs import" <|
            \() ->
                Imports.imports [ "Api" ] (Type.TypeReference ("Foo" |> ClassCaseName.build |> Type.EnumRef) Type.NonNullable)
                    |> Expect.equal (Just [ "Api", "Enum", "Foo" ])
        , test "filters out its own module name" <|
            \() ->
                Imports.importsWithoutSelf [ "Api" ] [ "Api", "Object", "Foo" ] [ listOfObjectRef ]
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
