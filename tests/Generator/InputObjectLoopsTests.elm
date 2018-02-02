module Generator.InputObjectLoopsTests exposing (all)

import Expect
import Graphqelm.Generator.InputObjectLoops as InputObjectLoops
import Graphqelm.Parser.CamelCaseName as CamelCaseName
import Graphqelm.Parser.ClassCaseName as ClassCaseName
import Graphqelm.Parser.Type exposing (DefinableType(..), Field, IsNullable(NonNullable), ReferrableType(InputObjectRef), TypeDefinition(TypeDefinition), TypeReference(TypeReference))
import Test exposing (Test, describe, test)


all : Test
all =
    describe "input object loops"
        [ test "no input objects in schema" <|
            \() ->
                [ TypeDefinition (ClassCaseName.build "SomeScalar") ScalarType Nothing ]
                    |> InputObjectLoops.any
                    |> Expect.equal False
        , test "no loop" <|
            \() ->
                [ TypeDefinition (ClassCaseName.build "MyInputObject")
                    (InputObjectType [ field "DifferentInputObject" "fieldName" ])
                    Nothing
                ]
                    |> InputObjectLoops.any
                    |> Expect.equal False
        , test "recursive" <|
            \() ->
                [ TypeDefinition (ClassCaseName.build "RecursiveInputObject")
                    (InputObjectType [ field "RecursiveInputObject" "fieldName" ])
                    Nothing
                ]
                    |> InputObjectLoops.any
                    |> Expect.equal True
        ]


field : String -> String -> Field
field inputObjectName fieldName =
    { name = CamelCaseName.build fieldName
    , description = Nothing
    , typeRef = TypeReference (InputObjectRef (ClassCaseName.build inputObjectName)) NonNullable
    , args = []
    }
