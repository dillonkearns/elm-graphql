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
                    |> Graphql.Document.serializeQuery
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
                    |> Graphql.Document.serializeQuery
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
                    |> Graphql.Document.serializeQuery
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
                    |> Graphql.Document.serializeQuery
                    |> Expect.equal """query {
  topLevel {
    avatar
    avatar
  }
}"""
        , test "ignored fields are omitted" <|
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

  }
}"""
        ]
