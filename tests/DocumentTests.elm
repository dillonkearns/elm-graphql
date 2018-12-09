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
  avatar0: avatar
}"""
        , test "single leaf for GET serializer" <|
            \() ->
                document [ leaf "avatar" [] ]
                    |> Graphql.Document.serializeQueryForUrl
                    |> Expect.equal """{avatar0:avatar}"""
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
                    |> Expect.equal "{topLevel{avatar0:avatar avatar0:avatar}}"
        , test "multiple top-level" <|
            \() ->
                document
                    [ leaf "avatar" []
                    , leaf "labels" []
                    ]
                    |> Graphql.Document.serializeQuery
                    |> Expect.equal """query {
  avatar0: avatar
  labels0: labels
}"""
        , test "duplicate top-level fields" <|
            \() ->
                document
                    [ leaf "avatar" []
                    , leaf "avatar" []
                    ]
                    |> Graphql.Document.serializeQuery
                    |> Expect.equal """query {
  avatar0: avatar
  avatar0: avatar
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
    avatar0: avatar
    avatar0: avatar
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
      __typename0: __typename
    }
  }
}"""
        , describe "empty queries"
            [ test "top-level empty query" <|
                \() ->
                    document []
                        |> Graphql.Document.serializeQuery
                        |> Expect.equal """query {
  __typename0: __typename
}"""
            , test "nested empty query" <|
                \() ->
                    document
                        [ Composite "viewer" [] []
                        ]
                        |> Graphql.Document.serializeQuery
                        |> Expect.equal """query {
  viewer {
    __typename0: __typename
  }
}"""
            ]
        ]
