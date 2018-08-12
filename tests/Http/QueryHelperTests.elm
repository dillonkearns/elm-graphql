module Http.QueryHelperTests exposing (all)

import Expect
import Graphqelm.Document as Document
import Graphqelm.Http.QueryHelper as QueryHelper
import Graphqelm.Operation exposing (RootMutation, RootQuery)
import Graphqelm.RawField exposing (RawField(..))
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet(..))
import Http
import Json.Decode as Decode
import Json.Encode
import Test exposing (Test, describe, test)


document : List RawField -> SelectionSet () RootQuery
document fields =
    SelectionSet fields (Decode.fail "")


longName1 : String
longName1 =
    String.repeat 1500 "a"


longName2 : String
longName2 =
    String.repeat 1500 "b"


all : Test
all =
    describe "document"
        [ test "uses GET when it is short enough" <|
            \() ->
                document [ Composite "hero" [] [ Leaf "name" [] ] ]
                    |> QueryHelper.build Nothing "https://graphqelm.herokuapp.com/api" []
                    |> Expect.equal
                        { method = QueryHelper.Get
                        , url = "https://graphqelm.herokuapp.com/api?query=%7Bhero%7Bname%7D%7D"
                        , body = Http.emptyBody
                        }
        , test "uses POST when it is short enough for GET but POST is forced" <|
            \() ->
                let
                    queryDocument =
                        document [ Composite "hero" [] [ Leaf "name" [] ] ]
                in
                queryDocument
                    |> QueryHelper.build (Just QueryHelper.Post) "https://graphqelm.herokuapp.com/api" []
                    |> Expect.equal
                        { method = QueryHelper.Post
                        , url = "https://graphqelm.herokuapp.com/api"
                        , body = Http.jsonBody (Json.Encode.object [ ( "query", Json.Encode.string (Document.serializeQuery queryDocument) ) ])
                        }
        , test "uses POST when it too long" <|
            \() ->
                let
                    queryDocument =
                        document
                            [ Composite "hero"
                                []
                                [ Leaf longName1 []
                                , Leaf longName2 []
                                ]
                            ]
                in
                queryDocument
                    |> QueryHelper.build Nothing "https://graphqelm.herokuapp.com/api" []
                    |> Expect.equal
                        { method = QueryHelper.Post
                        , url = "https://graphqelm.herokuapp.com/api"
                        , body = Http.jsonBody (Json.Encode.object [ ( "query", Json.Encode.string (Document.serializeQuery queryDocument) ) ])
                        }
        ]
