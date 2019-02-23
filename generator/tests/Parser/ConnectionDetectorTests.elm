module Parser.ConnectionDetectorTests exposing (all)

import Expect
import Graphql.Parser.CamelCaseName as CamelCaseName
import Graphql.Parser.ClassCaseName as ClassCaseName
import Graphql.Parser.Scalar as Scalar
import Graphql.Parser.Type as Type exposing (DefinableType, IsNullable(..), TypeDefinition(..), TypeReference(..))
import Test exposing (Test, describe, test)


type DetectionResult
    = Miss
    | SpecViolation
    | Match


isConnection : TypeDefinition -> List TypeDefinition -> DetectionResult
isConnection (TypeDefinition typeName definableType description) allDefinitions =
    if typeName |> ClassCaseName.raw |> String.endsWith "Connection" then
        SpecViolation

    else
        Miss


all : Test
all =
    describe "detect connections"
        [ describe "non-objects"
            [ test "scalar is not a Connection" <|
                \() ->
                    isConnection
                        (typeDefinition "SomeInputObject" (Type.InputObjectType [ field "String" "hello" ]))
                        []
                        |> Expect.equal Miss
            ]
        , describe "objects"
            [ test "Object with correct name violates convention, should warn" <|
                \() ->
                    isConnection
                        (typeDefinition "StargazerConnection" (Type.InputObjectType [ field "String" "hello" ]))
                        []
                        |> Expect.equal SpecViolation

            {-
               {
                 repository(owner: "dillonkearns", name: "elm-graphql") {
                   stargazers(first: 10, after: null) {
                     totalCount
                     pageInfo {
                       hasNextPage
                       endCursor
                     }
                     edges {
                       node {
                         login
                       }
                       starredAt
                     }
                   }
                 }
               }

            -}
            , test "strict spec match" <|
                \() ->
                    isConnection
                        (typeDefinition "StargazerConnection" (Type.ObjectType [ field "PageInfo" "pageInfo" ]))
                        [ strictPageInfoDefinition
                        , typeDefinition "StargazerEdge" (Type.InputObjectType [ field "String" "hello" ])
                        ]
                        |> Expect.equal SpecViolation
            ]
        ]


typeDefinition : String -> DefinableType -> TypeDefinition
typeDefinition classCaseName definableType =
    TypeDefinition (ClassCaseName.build classCaseName) definableType Nothing


strictPageInfoDefinition : TypeDefinition
strictPageInfoDefinition =
    typeDefinition "PageInfo"
        (Type.ObjectType
            [ fieldNew "hasPreviousPage" (Type.Scalar Scalar.Boolean) NonNullable
            , fieldNew "hasNextPage" (Type.Scalar Scalar.Boolean) NonNullable
            , fieldNew "startCursor" (Type.Scalar Scalar.String) Nullable
            , fieldNew "endCursor" (Type.Scalar Scalar.String) Nullable
            ]
        )


fieldNew : String -> Type.ReferrableType -> IsNullable -> Type.Field
fieldNew fieldName reference isNullable =
    { name = CamelCaseName.build fieldName
    , description = Nothing
    , typeRef = TypeReference reference isNullable
    , args = []
    }


field : String -> String -> Type.Field
field inputObjectName fieldName =
    { name = CamelCaseName.build fieldName
    , description = Nothing
    , typeRef = TypeReference (Type.InputObjectRef (ClassCaseName.build inputObjectName)) NonNullable
    , args = []
    }
