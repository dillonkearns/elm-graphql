module DocumentTests exposing (all)

import Expect
import Graphqelm
import Graphqelm.Document
import Graphqelm.Field exposing (Field(Composite, Leaf))
import Graphqelm.SelectionSet exposing (SelectionSet(SelectionSet))
import Json.Decode as Decode
import Test exposing (Test, describe, test)


document : List Field -> SelectionSet () Graphqelm.RootQuery
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
        ]
