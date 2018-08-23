module Generator.InputObjectLoopsTests exposing (all)

import Expect
import Graphql.Generator.InputObjectLoops as InputObjectLoops
import Graphql.Parser.CamelCaseName as CamelCaseName
import Graphql.Parser.ClassCaseName as ClassCaseName
import Graphql.Parser.Type as Type exposing (DefinableType(..), Field, IsNullable(..), ReferrableType(..), TypeDefinition(..), TypeReference(..))
import Test exposing (Test, describe, only, test)


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
        , test "circular" <|
            \() ->
                [ TypeDefinition (ClassCaseName.build "CircularInputObjectOne")
                    (InputObjectType [ field "CircularInputObjectTwo" "fieldNameOne" ])
                    Nothing
                , TypeDefinition (ClassCaseName.build "CircularInputObjectTwo")
                    (InputObjectType [ field "CircularInputObjectOne" "fieldNameTwo" ])
                    Nothing
                ]
                    |> InputObjectLoops.any
                    |> Expect.equal True
        , test "doubly nested non-circular" <|
            \() ->
                [ TypeDefinition (ClassCaseName.build "CircularInputObjectOne")
                    (InputObjectType [ field "CircularInputObjectTwo" "fieldNameOne" ])
                    Nothing
                , TypeDefinition (ClassCaseName.build "CircularInputObjectTwo")
                    (InputObjectType [ field "CircularInputObjectThree" "fieldNameTwo" ])
                    Nothing
                , TypeDefinition (ClassCaseName.build "CircularInputObjectThree") ScalarType Nothing
                ]
                    |> InputObjectLoops.any
                    |> Expect.equal False
        , test "doubly nested circular" <|
            \() ->
                [ TypeDefinition (ClassCaseName.build "CircularInputObjectOne")
                    (InputObjectType [ field "CircularInputObjectTwo" "fieldNameOne" ])
                    Nothing
                , TypeDefinition (ClassCaseName.build "CircularInputObjectTwo")
                    (InputObjectType [ field "CircularInputObjectThree" "fieldNameTwo" ])
                    Nothing
                , TypeDefinition (ClassCaseName.build "CircularInputObjectThree")
                    (InputObjectType [ field "CircularInputObjectOne" "fieldNameThree" ])
                    Nothing
                ]
                    |> InputObjectLoops.any
                    |> Expect.equal True
        , test "nested loops through list reference" <|
            \() ->
                [ TypeDefinition (ClassCaseName.build "CircularInputObjectOne")
                    (InputObjectType [ field "CircularInputObjectTwo" "fieldNameOne" ])
                    Nothing
                , TypeDefinition (ClassCaseName.build "CircularInputObjectTwo")
                    (InputObjectType [ fieldListRef "CircularInputObjectThree" "fieldNameTwo" ])
                    Nothing
                , TypeDefinition (ClassCaseName.build "CircularInputObjectThree")
                    (InputObjectType [ field "CircularInputObjectOne" "fieldNameThree" ])
                    Nothing
                ]
                    |> InputObjectLoops.any
                    |> Expect.equal True
        , test "deeploy nested loops through list reference" <|
            \() ->
                [ TypeDefinition (ClassCaseName.build "CircularInputObjectOne")
                    (InputObjectType [ field "CircularInputObjectTwo" "fieldNameOne" ])
                    Nothing
                , TypeDefinition (ClassCaseName.build "CircularInputObjectTwo")
                    (InputObjectType [ fieldListRef "CircularInputObjectThree" "fieldNameTwo" ])
                    Nothing
                , TypeDefinition (ClassCaseName.build "CircularInputObjectThree")
                    (InputObjectType [ field "CircularInputObjectOne" "fieldNameThree" ])
                    Nothing
                ]
                    |> InputObjectLoops.any
                    |> Expect.equal True
        , test "recursive loop through list reference" <|
            \() ->
                [ TypeDefinition (ClassCaseName.build "CircularInputObject")
                    (InputObjectType [ fieldListRef "CircularInputObject" "recursiveListField" ])
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


fieldListRef : String -> String -> Field
fieldListRef inputObjectName fieldName =
    { name = CamelCaseName.build fieldName
    , description = Nothing
    , typeRef = TypeReference (Type.List (TypeReference (InputObjectRef (ClassCaseName.build inputObjectName)) NonNullable)) NonNullable
    , args = []
    }
