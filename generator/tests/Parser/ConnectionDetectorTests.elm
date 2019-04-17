module Parser.ConnectionDetectorTests exposing (all)

import Expect
import Graphql.Parser.CamelCaseName as CamelCaseName
import Graphql.Parser.ClassCaseName as ClassCaseName
import Graphql.Parser.Scalar as Scalar
import Graphql.Parser.Type as Type exposing (DefinableType(..), IsNullable(..), ReferrableType(..), TypeDefinition(..), TypeReference(..))
import Test exposing (Test, describe, test)


type DetectionResult
    = Miss
    | SpecViolation
    | Match


isConnection : Type.Field -> List TypeDefinition -> DetectionResult
isConnection candidateField allDefinitions =
    if hasArgs candidateField then
        Match

    else
        Miss


hasPageInfo : List TypeDefinition -> Bool
hasPageInfo allDefinitions =
    List.any (\def -> isPageInfo def)
        allDefinitions


isPageInfo : TypeDefinition -> Bool
isPageInfo (TypeDefinition name typeDef description) =
    ClassCaseName.raw name
        == "PageInfo"
        && (case typeDef of
                Type.ObjectType fields ->
                    List.any (\currentField -> CamelCaseName.raw currentField.name == "endCursor") fields

                _ ->
                    False
           )


hasArgs candidateField =
    hasArg "first" candidateField.args
        && hasArg "last" candidateField.args
        && hasArg "after" candidateField.args
        && hasArg "before" candidateField.args


hasArg argName args =
    List.filter (\arg -> CamelCaseName.raw arg.name == argName) args /= []


all : Test
all =
    describe "detect connections"
        [ describe "non-objects"
            [ test "scalar is not a Connection" <|
                \() ->
                    isConnection
                        (field "String" "hello")
                        []
                        |> Expect.equal Miss
            ]
        , describe "objects"
            [ -- test "Object with correct name violates convention, should warn" <|
              --     \() ->
              --         isConnection
              --             (fieldNew "totalCount" (Type.Scalar Scalar.Int) NonNullable)
              --             []
              --             |> Expect.equal SpecViolation
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
              test "strict spec match" <|
                \() ->
                    isConnection
                        properField
                        properConnectionExample
                        |> Expect.equal Match
            ]
        , describe "has page info"
            [ test "same name but doesn't match" <|
                \() ->
                    isPageInfo
                        (TypeDefinition (ClassCaseName.build "PageInfo")
                            (ObjectType
                                [ { args = [], description = Nothing, name = CamelCaseName.build "notRealPageInfo", typeRef = TypeReference (Type.Scalar Scalar.String) Nullable }
                                ]
                            )
                            Nothing
                        )
                        |> Expect.equal False
            , test "present" <|
                \() ->
                    isPageInfo properPageInfo
                        |> Expect.equal True
            ]
        ]


typeDefinition : String -> DefinableType -> TypeDefinition
typeDefinition classCaseName definableType =
    TypeDefinition (ClassCaseName.build classCaseName) definableType Nothing


properPageInfo : TypeDefinition
properPageInfo =
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


properConnectionExample =
    [ properPageInfo
    , TypeDefinition (ClassCaseName.build "Query")
        (ObjectType
            [ properField
            ]
        )
        Nothing
    , TypeDefinition (ClassCaseName.build "StargazerConnection") (ObjectType [ { args = [], description = Just "", name = CamelCaseName.build "edges", typeRef = TypeReference (List (TypeReference (ObjectRef "StargazerEdge") Nullable)) Nullable }, { args = [], description = Just "", name = CamelCaseName.build "pageInfo", typeRef = TypeReference (ObjectRef "PageInfo") NonNullable }, { args = [], description = Just "", name = CamelCaseName.build "totalCount", typeRef = TypeReference (Type.Scalar Scalar.Int) NonNullable } ]) Nothing
    , TypeDefinition (ClassCaseName.build "StargazerEdge") (ObjectType [ { args = [], description = Just "", name = CamelCaseName.build "cursor", typeRef = TypeReference (Type.Scalar Scalar.String) NonNullable }, { args = [], description = Just "", name = CamelCaseName.build "node", typeRef = TypeReference (ObjectRef "User") NonNullable } ]) Nothing
    , TypeDefinition (ClassCaseName.build "User") (ObjectType [ { args = [], description = Just "", name = CamelCaseName.build "name", typeRef = TypeReference (Type.Scalar Scalar.String) NonNullable } ]) Nothing
    ]


properField =
    { args =
        [ buildArg "after" (Type.Scalar Scalar.String) Nullable
        , buildArg "before" (Type.Scalar Scalar.String) Nullable
        , buildArg "first" (Type.Scalar Scalar.Int) Nullable
        , buildArg "last" (Type.Scalar Scalar.Int) Nullable
        ]
    , description = Nothing
    , name = CamelCaseName.build "stargazers"
    , typeRef = TypeReference (ObjectRef "StargazerConnection") NonNullable
    }


buildArg name topLevelType isNullable =
    { description = Nothing
    , name = CamelCaseName.build name
    , typeRef = TypeReference topLevelType isNullable
    }



{-
   https://github.com/facebook/relay/blob/master/website/spec/Connections.md

   - Object type
   - Ends in "Connection"
   - Has "edges" field, List of edge type
   - Has "pageInfo" field, non-null, of type PageInfo
-}
