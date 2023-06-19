module DocumentTests exposing (all)

import Expect
import Graphql.Document
import Graphql.Internal.Builder.Argument
import Graphql.Internal.Encode
import Graphql.Operation exposing (RootMutation, RootQuery)
import Graphql.RawField exposing (RawField(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet(..))
import Json.Decode as Decode
import Test exposing (Test, describe, test)


intArg : { key : String, value : Int } -> Graphql.Internal.Builder.Argument.Argument
intArg { key, value } =
    Graphql.Internal.Builder.Argument.required key value Graphql.Internal.Encode.int


document : List RawField -> SelectionSet () RootQuery
document fields =
    SelectionSet fields (Decode.fail "")


leaf : String -> List Graphql.Internal.Builder.Argument.Argument -> RawField
leaf fieldName arguments =
    Leaf { typeString = "", fieldName = fieldName } arguments


all : Test
all =
    describe "document"
        [ test "single leaf" <|
            \() ->
                document [ leaf "avatar" [] ]
                    |> Graphql.Document.serializeQuery
                    |> Expect.equal """query {
  avatar
}"""
        , test "single leaf for GET serializer" <|
            \() ->
                document [ leaf "avatar" [] ]
                    |> Graphql.Document.serializeQueryForUrl
                    |> Expect.equal """{avatar}"""
        , test "duplicate nested fields for GET serializer" <|
            \() ->
                document
                    [ Composite "topLevel"
                        []
                        [ leaf "avatar" []
                        , leaf "avatar" []
                        ]
                    ]
                    |> Graphql.Document.serializeQueryForUrl
                    |> Expect.equal "{topLevel{avatar}}"
        , test "multiple top-level" <|
            \() ->
                document
                    [ leaf "avatar" []
                    , leaf "labels" []
                    ]
                    |> Graphql.Document.serializeQuery
                    |> Expect.equal """query {
  avatar
  labels
}"""
        , test "duplicate top-level fields" <|
            \() ->
                document
                    [ leaf "avatar" []
                    , leaf "avatar" []
                    ]
                    |> Graphql.Document.serializeQuery
                    |> Expect.equal """query {
  avatar
}"""
        , test "duplicate nested fields" <|
            \() ->
                document
                    [ Composite "topLevel"
                        []
                        [ leaf "avatar" []
                        , leaf "avatar" []
                        ]
                    ]
                    |> Graphql.Document.serializeQuery
                    |> Expect.equal """query {
  topLevel {
    avatar
  }
}"""
        , test "ignored fields are included with a typename" <|
            \() ->
                document
                    [ Composite "topLevel"
                        []
                        [ Composite "...on Droid" [] []
                        ]
                    ]
                    |> Graphql.Document.serializeQuery
                    |> Expect.equal """query {
  topLevel {
    ...on Droid {
      __typename
    }
  }
}"""
        , describe "empty queries"
            [ test "top-level empty query" <|
                \() ->
                    document []
                        |> Graphql.Document.serializeQuery
                        |> Expect.equal """query {
  __typename
}"""
            , test "nested empty query" <|
                \() ->
                    document
                        [ Composite "viewer" [] []
                        ]
                        |> Graphql.Document.serializeQuery
                        |> Expect.equal """query {
  viewer {
    __typename
  }
}"""
            ]
        , describe "with operation name"
            [ test "single leaf" <|
                \() ->
                    document [ leaf "avatar" [] ]
                        |> Graphql.Document.serializeQueryWithOperationName "Avatar"
                        |> Expect.equal """query Avatar {
  avatar
}"""
            , test "single leaf for GET serializer" <|
                \() ->
                    document [ leaf "avatar" [] ]
                        |> Graphql.Document.serializeQueryForUrlWithOperationName "Avatar"
                        |> Expect.equal """query Avatar {avatar}"""
            ]
        , describe "merge composite fields"
            [ test "without arguments" <|
                \() ->
                    document
                        [ Composite "me"
                            []
                            [ leaf "firstName" []
                            ]
                        , Composite "me"
                            []
                            [ leaf "lastName" []
                            ]
                        ]
                        |> Graphql.Document.serializeQuery
                        |> Expect.equal """query {
  me {
    firstName
    lastName
  }
}"""
            , test "merges 3 with no args" <|
                \() ->
                    document
                        [ Composite "me"
                            []
                            [ leaf "firstName" []
                            ]
                        , Composite "me"
                            []
                            [ leaf "middleName" []
                            ]
                        , Composite "me"
                            []
                            [ leaf "lastName" []
                            ]
                        ]
                        |> Graphql.Document.serializeQuery
                        |> Expect.equal """query {
  me {
    firstName
    middleName
    lastName
  }
}"""
            , test "different arguments are not merged" <|
                \() ->
                    document
                        [ Composite "me"
                            [ Graphql.Internal.Builder.Argument.Argument "id" (Graphql.Internal.Encode.int 123)
                            ]
                            [ leaf "firstName" []
                            ]
                        , Composite "me"
                            [ Graphql.Internal.Builder.Argument.Argument "id" (Graphql.Internal.Encode.int 456)
                            ]
                            [ leaf "lastName" []
                            ]
                        ]
                        |> Graphql.Document.serializeQuery
                        |> Expect.equal """query {
  me3003759287: me(id: 123) {
    firstName
  }
  me1529416052: me(id: 456) {
    lastName
  }
}"""
            , test "identical leaves are de-duped" <|
                \() ->
                    document
                        [ leaf "version" []
                        , leaf "version" []
                        ]
                        |> Graphql.Document.serializeQuery
                        |> Expect.equal """query {
  version
}"""
            , test "identical leaves from a merged Composite parent de-duped" <|
                \() ->
                    document
                        [ Composite "me"
                            [ Graphql.Internal.Builder.Argument.Argument "id" (Graphql.Internal.Encode.int 123)
                            ]
                            [ leaf "firstName" []
                            ]
                        , Composite "me"
                            [ Graphql.Internal.Builder.Argument.Argument "id" (Graphql.Internal.Encode.int 123)
                            ]
                            [ leaf "firstName" []
                            ]
                        ]
                        |> Graphql.Document.serializeQuery
                        |> Expect.equal """query {
  me(id: 123) {
    firstName
  }
}"""
            , test "identical fields with diffrent parameters are hashed." <|
                \() ->
                    document
                        [ Composite "me"
                            [ Graphql.Internal.Builder.Argument.Argument "id" (Graphql.Internal.Encode.int 123)
                            ]
                            [ leaf "firstName" []
                            ]
                        , Composite "me"
                            [ Graphql.Internal.Builder.Argument.Argument "id" (Graphql.Internal.Encode.int 456)
                            ]
                            [ leaf "firstName" []
                            ]
                        ]
                        |> Graphql.Document.serializeQuery
                        |> Expect.equal """query {
  me3003759287: me(id: 123) {
    firstName
  }
  me1529416052: me(id: 456) {
    firstName
  }
}"""
            , test "identical fields are hashed with diffrent parameters are hashed but unique fields are not" <|
                \() ->
                    document
                        [ leaf "avatar" []
                        , Composite "me"
                            [ Graphql.Internal.Builder.Argument.Argument "id" (Graphql.Internal.Encode.int 123)
                            ]
                            [ leaf "firstName" []
                            ]
                        , Composite "me"
                            [ Graphql.Internal.Builder.Argument.Argument "id" (Graphql.Internal.Encode.int 456)
                            ]
                            [ leaf "firstName" []
                            ]
                        ]
                        |> Graphql.Document.serializeQuery
                        |> Expect.equal """query {
  avatar
  me3003759287: me(id: 123) {
    firstName
  }
  me1529416052: me(id: 456) {
    firstName
  }
}"""
            , test "identical fields are hashed but unique fields are not even though there are duplicate fields" <|
                \() ->
                    document
                        [ leaf "avatar" []
                        , leaf "avatar" []
                        , Composite "me"
                            [ Graphql.Internal.Builder.Argument.Argument "id" (Graphql.Internal.Encode.int 123)
                            ]
                            [ leaf "firstName" []
                            ]
                        , Composite "me"
                            [ Graphql.Internal.Builder.Argument.Argument "id" (Graphql.Internal.Encode.int 456)
                            ]
                            [ leaf "firstName" []
                            ]
                        ]
                        |> Graphql.Document.serializeQuery
                        |> Expect.equal """query {
  avatar
  me3003759287: me(id: 123) {
    firstName
  }
  me1529416052: me(id: 456) {
    firstName
  }
}"""
            , test "identical fields with same arguments are not hashed" <|
                \() ->
                    document
                        [ Composite "me"
                            [ Graphql.Internal.Builder.Argument.Argument "id" (Graphql.Internal.Encode.int 123)
                            ]
                            [ leaf "firstName" []
                            ]
                        , Composite "me"
                            [ Graphql.Internal.Builder.Argument.Argument "id" (Graphql.Internal.Encode.int 123)
                            ]
                            [ leaf "firstName" []
                            ]
                        ]
                        |> Graphql.Document.serializeQuery
                        |> Expect.equal """query {
  me(id: 123) {
    firstName
  }
}"""
            , test "identical fields with same arguments but diffrent selections are merged" <|
                \() ->
                    document
                        [ Composite "me"
                            [ Graphql.Internal.Builder.Argument.Argument "id" (Graphql.Internal.Encode.int 123)
                            ]
                            [ leaf "firstName" []
                            ]
                        , Composite "me"
                            [ Graphql.Internal.Builder.Argument.Argument "id" (Graphql.Internal.Encode.int 123)
                            ]
                            [ leaf "lastName" []
                            ]
                        ]
                        |> Graphql.Document.serializeQuery
                        |> Expect.equal """query {
  me(id: 123) {
    firstName
    lastName
  }
}"""
            , test "identical fields with same arguments but diffrent selections are merged along with union selection" <|
                \() ->
                    document
                        [ Composite "me"
                            [ Graphql.Internal.Builder.Argument.Argument "id" (Graphql.Internal.Encode.int 123)
                            ]
                            [ leaf "firstName" []
                            ]
                        , Composite "me"
                            [ Graphql.Internal.Builder.Argument.Argument "id" (Graphql.Internal.Encode.int 123)
                            ]
                            [ leaf "lastName" []
                            ]
                        , Composite "topLevel"
                            []
                            [ Composite "...on Droid" [] []
                            ]
                        ]
                        |> Graphql.Document.serializeQuery
                        |> Expect.equal """query {
  me(id: 123) {
    firstName
    lastName
  }
  topLevel {
    ...on Droid {
      __typename
    }
  }
}"""
            , test "identical fields are hashed." <|
                \() ->
                    document
                        [ leaf "avatar" []
                        , leaf "avatar" [ intArg { key = "size", value = 1 } ]
                        , Composite "me"
                            [ Graphql.Internal.Builder.Argument.Argument "id" (Graphql.Internal.Encode.int 123)
                            ]
                            [ leaf "firstName" []
                            ]
                        , Composite "me"
                            [ Graphql.Internal.Builder.Argument.Argument "id" (Graphql.Internal.Encode.int 456)
                            ]
                            [ leaf "firstName" []
                            ]
                        ]
                        |> Graphql.Document.serializeQuery
                        |> Expect.equal """query {
  avatar0: avatar
  avatar2648687506: avatar(size: 1)
  me3003759287: me(id: 123) {
    firstName
  }
  me1529416052: me(id: 456) {
    firstName
  }
}"""
            , test "sibling fields with same name but different type are hashed" <|
                \() ->
                    document
                        [ Composite "topLevel"
                            []
                            [ Composite "...on StringValue"
                                []
                                [ Leaf { typeString = "String", fieldName = "value" } []
                                ]
                            , Composite "...on BoolValue"
                                []
                                [ Leaf { typeString = "Bool", fieldName = "value" } []
                                ]
                            ]
                        ]
                        |> Graphql.Document.serializeQuery
                        |> Expect.equal
                            """query {
  topLevel {
    ...on StringValue {
      value3832528868: value
    }
    ...on BoolValue {
      value3880003826: value
    }
  }
}"""
            , test "duplicate fields are merged and still only hashed as needed" <|
                \() ->
                    document
                        [ leaf "avatar" []
                        , leaf "avatar" []
                        , Composite "me"
                            [ Graphql.Internal.Builder.Argument.Argument "id" (Graphql.Internal.Encode.int 123)
                            ]
                            [ leaf "firstName" []
                            , leaf "firstName" []
                            , leaf "avatar" [ intArg { key = "size", value = 1 } ]
                            , leaf "avatar" [ intArg { key = "size", value = 2 } ]
                            ]
                        , Composite "me"
                            [ Graphql.Internal.Builder.Argument.Argument "id" (Graphql.Internal.Encode.int 123)
                            ]
                            [ leaf "firstName" []
                            , leaf "firstName" []
                            ]
                        ]
                        |> Graphql.Document.serializeQuery
                        |> Expect.equal """query {
  avatar
  me(id: 123) {
    firstName
    avatar2648687506: avatar(size: 1)
    avatar76140203: avatar(size: 2)
  }
}"""
            ]
        ]
