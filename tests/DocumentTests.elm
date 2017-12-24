module DocumentTests exposing (all)

import Expect
import Graphqelm
import Graphqelm.Document
import Graphqelm.Field exposing (Field(Leaf))
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
  result1: viewer
}"""
        , test "multiple top-level" <|
            \() ->
                document [ Leaf "viewer" [], Leaf "labels" [] ]
                    |> Graphqelm.Document.serializeQuery
                    |> Expect.equal """query {
  result1: viewer
  result2: labels
}"""
        ]
