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


intArg { key, value } =
    Graphql.Internal.Builder.Argument.required key value Graphql.Internal.Encode.int


document : List RawField -> SelectionSet () RootQuery
document fields =
    SelectionSet fields (Decode.fail "")


all : Test
all =
    describe "document"
        [ test "single leaf" <|
            \() ->
                document [ Leaf "avatar" [] ]
                    |> Graphql.Document.serializeQuery Nothing
                    |> Expect.equal """query {
  avatar
}"""
        , test "single leaf for GET serializer" <|
            \() ->
                document [ Leaf "avatar" [] ]
                    |> Graphql.Document.serializeQueryForUrl
                    |> Expect.equal """{avatar}"""
        , test "duplicate nested fields for GET serializer" <|
            \() ->
                document
                    [ Composite "topLevel"
                        []
                        [ Leaf "avatar" []
                        , Leaf "avatar" []
                        ]
                    ]
                    |> Graphql.Document.serializeQueryForUrl
                    |> Expect.equal "{topLevel{avatar avatar}}"
        , test "multiple top-level" <|
            \() ->
                document
                    [ Leaf "avatar" []
                    , Leaf "labels" []
                    ]
                    |> Graphql.Document.serializeQuery Nothing
                    |> Expect.equal """query {
  avatar
  labels
}"""
        , test "duplicate top-level fields" <|
            \() ->
                document
                    [ Leaf "avatar" []
                    , Leaf "avatar" []
                    ]
                    |> Graphql.Document.serializeQuery Nothing
                    |> Expect.equal """query {
  avatar
  avatar
}"""
        , test "duplicate nested fields" <|
            \() ->
                document
                    [ Composite "topLevel"
                        []
                        [ Leaf "avatar" []
                        , Leaf "avatar" []
                        ]
                    ]
                    |> Graphql.Document.serializeQuery Nothing
                    |> Expect.equal """query {
  topLevel {
    avatar
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
                    |> Graphql.Document.serializeQuery Nothing
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
                        |> Graphql.Document.serializeQuery Nothing
                        |> Expect.equal """query {
  __typename
}"""
            , test "nested empty query" <|
                \() ->
                    document
                        [ Composite "viewer" [] []
                        ]
                        |> Graphql.Document.serializeQuery Nothing
                        |> Expect.equal """query {
  viewer {
    __typename
  }
}"""
            , test "named operation query" <|
                \() ->
                    document
                        [ Composite "viewer" [] []
                        ]
                        |> Graphql.Document.serializeQuery (Just "namedOperation")
                        |> Expect.equal """query namedOperation {
  viewer {
    __typename
  }
}"""
            ]
        ]
