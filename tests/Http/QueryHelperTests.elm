module Http.QueryHelperTests exposing (all)

import Expect
import Graphqelm.Http.QueryHelper as QueryHelper
import Graphqelm.Operation exposing (RootMutation, RootQuery)
import Graphqelm.RawField exposing (RawField(Composite, Leaf))
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet(SelectionSet))
import Http
import Json.Decode as Decode
import Test exposing (Test, describe, test)


document : List RawField -> SelectionSet () RootQuery
document fields =
    SelectionSet fields (Decode.fail "")


all : Test
all =
    describe "document"
        [ test "uses query when it is short enough" <|
            \() ->
                document
                    [ Composite "hero"
                        []
                        [ Leaf "name" []
                        ]
                    ]
                    |> QueryHelper.build Nothing "https://graphqelm.herokuapp.com/api" []
                    |> Expect.equal
                        { method = QueryHelper.Get
                        , url = "https://graphqelm.herokuapp.com/api?query=%7Bhero%7Bname%7D%7D"
                        , body = Http.emptyBody
                        }
        ]
