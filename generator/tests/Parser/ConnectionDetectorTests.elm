module Parser.ConnectionDetectorTests exposing (all)

import Expect
import Graphql.Parser.CamelCaseName as CamelCaseName
import Graphql.Parser.ClassCaseName as ClassCaseName
import Graphql.Parser.Type as Type exposing (IsNullable(..), TypeDefinition(..), TypeReference(..))
import Test exposing (Test, describe, test)


type DetectionResult
    = Miss
    | SpecViolation
    | Match


isConnection : TypeDefinition -> DetectionResult
isConnection (TypeDefinition typeName definableType description) =
    if typeName |> ClassCaseName.raw |> String.endsWith "Connection" then
        SpecViolation

    else
        Miss


field : String -> String -> Type.Field
field inputObjectName fieldName =
    { name = CamelCaseName.build fieldName
    , description = Nothing
    , typeRef = TypeReference (Type.InputObjectRef (ClassCaseName.build inputObjectName)) NonNullable
    , args = []
    }


all : Test
all =
    describe "detect connections"
        [ describe "non-objects"
            [ test "scalar is not a Connection" <|
                \() ->
                    TypeDefinition (ClassCaseName.build "SomeInputObject")
                        (Type.InputObjectType [ field "String" "hello" ])
                        Nothing
                        |> isConnection
                        |> Expect.equal Miss
            ]
        , describe "objects"
            [ test "Object with correct name violates convention, should warn" <|
                \() ->
                    TypeDefinition (ClassCaseName.build "StargazerConnection")
                        (Type.InputObjectType [ field "String" "hello" ])
                        Nothing
                        |> isConnection
                        |> Expect.equal SpecViolation
            ]
        ]
