module DocumentTests exposing (all)

import Expect
import Graphqelm.Document
import Graphqelm.Operation exposing (RootMutation, RootQuery)
import Graphqelm.RawField exposing (RawField(..))
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet(..))
import Json.Decode as Decode
import Test exposing (Test, describe, test)


document : List RawField -> SelectionSet () RootQuery
document fields =
    SelectionSet fields (Decode.fail "")


all : Test
all =
    describe "document"
        [ test "single leaf" <|
            \() ->
                document [ Leaf "viewer" [] ]
                    |> Graphqelm.Document.serializeQuery
                    |> Expect.equal """query {
  viewer
}"""
        , test "single leaf for GET serializer" <|
            \() ->
                document [ Leaf "viewer" [] ]
                    |> Graphqelm.Document.serializeQueryForUrl
                    |> Expect.equal """{viewer}"""
        , test "duplicate nested fields for GET serializer" <|
            \() ->
                document
                    [ Composite "topLevel"
                        []
                        [ Leaf "viewer" []
                        , Leaf "viewer" []
                        ]
                    ]
                    |> Graphqelm.Document.serializeQueryForUrl
                    |> Expect.equal "{topLevel{viewer viewer2:viewer}}"
        , test "multiple top-level" <|
            \() ->
                document [ Leaf "viewer" [], Leaf "labels" [] ]
                    |> Graphqelm.Document.serializeQuery
                    |> Expect.equal """query {
  viewer
  labels
}"""
        , test "duplicate top-level fields" <|
            \() ->
                document
                    [ Leaf "viewer" []
                    , Leaf "viewer" []
                    ]
                    |> Graphqelm.Document.serializeQuery
                    |> Expect.equal """query {
  viewer
  viewer2: viewer
}"""
        , test "duplicate nested fields" <|
            \() ->
                document
                    [ Composite "topLevel"
                        []
                        [ Leaf "viewer" []
                        , Leaf "viewer" []
                        ]
                    ]
                    |> Graphqelm.Document.serializeQuery
                    |> Expect.equal """query {
  topLevel {
    viewer
    viewer2: viewer
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
                    |> Graphqelm.Document.serializeQuery
                    |> Expect.equal """query {
  topLevel {

  }
}"""
        ]
