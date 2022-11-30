module Http.QueryHelperTests exposing (all)

import Expect
import Graphql.Document as Document
import Graphql.Http.QueryHelper as QueryHelper
import Graphql.Internal.Builder.Argument exposing (Argument)
import Graphql.Operation exposing (RootMutation, RootQuery)
import Graphql.RawField exposing (RawField(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet(..))
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


leaf : String -> List Argument -> RawField
leaf fieldName arguments =
    Leaf { typeString = "", fieldName = fieldName } arguments


all : Test
all =
    describe "document"
        [ test "uses GET when it is short enough" <|
            \() ->
                document [ Composite "hero" [] [ leaf "name" [] ] ]
                    |> QueryHelper.build Nothing "https://elm-graphql.onrender.com/api" [] Nothing
                    |> Expect.equal
                        { method = QueryHelper.Get
                        , url = "https://elm-graphql.onrender.com/api?query=%7Bhero%7Bname%7D%7D"
                        , body = Http.emptyBody
                        }
        , test "uses GET when it is short enough, with operation name" <|
            \() ->
                document [ Composite "hero" [] [ leaf "name" [] ] ]
                    |> QueryHelper.build Nothing "https://elm-graphql.onrender.com/api" [] (Just "OpName")
                    |> Expect.equal
                        { method = QueryHelper.Get
                        , url = "https://elm-graphql.onrender.com/api?query=query+OpName+%7Bhero%7Bname%7D%7D&operationName=OpName"
                        , body = Http.emptyBody
                        }
        , test "uses POST when it is short enough for GET but POST is forced" <|
            \() ->
                let
                    queryDocument =
                        document [ Composite "hero" [] [ leaf "name" [] ] ]
                in
                queryDocument
                    |> QueryHelper.build (Just QueryHelper.Post) "https://elm-graphql.onrender.com/api" [] Nothing
                    |> Expect.equal
                        { method = QueryHelper.Post
                        , url = "https://elm-graphql.onrender.com/api"
                        , body = Http.jsonBody (Json.Encode.object [ ( "query", Json.Encode.string (Document.serializeQuery queryDocument) ) ])
                        }
        , test "uses POST when it too long" <|
            \() ->
                let
                    queryDocument =
                        document
                            [ Composite "hero"
                                []
                                [ leaf longName1 []
                                , leaf longName2 []
                                ]
                            ]
                in
                queryDocument
                    |> QueryHelper.build Nothing "https://elm-graphql.onrender.com/api" [] Nothing
                    |> Expect.equal
                        { method = QueryHelper.Post
                        , url = "https://elm-graphql.onrender.com/api"
                        , body = Http.jsonBody (Json.Encode.object [ ( "query", Json.Encode.string (Document.serializeQuery queryDocument) ) ])
                        }
        , test "passes through query params for POST requests" <|
            \() ->
                let
                    queryDocument =
                        document
                            [ Composite "hero"
                                []
                                [ leaf longName1 []
                                , leaf longName2 []
                                ]
                            ]
                in
                queryDocument
                    |> QueryHelper.build Nothing
                        "https://elm-graphql.onrender.com/api"
                        [ ( "send", "it" ) ]
                        Nothing
                    |> Expect.equal
                        { method = QueryHelper.Post
                        , url = "https://elm-graphql.onrender.com/api?send=it"
                        , body = Http.jsonBody (Json.Encode.object [ ( "query", Json.Encode.string (Document.serializeQuery queryDocument) ) ])
                        }
        , test "uses POST when it too long, with operation name" <|
            \() ->
                let
                    queryDocument =
                        document
                            [ Composite "hero"
                                []
                                [ leaf longName1 []
                                , leaf longName2 []
                                ]
                            ]
                in
                queryDocument
                    |> QueryHelper.build Nothing "https://elm-graphql.onrender.com/api" [] (Just "OpName")
                    |> Expect.equal
                        { method = QueryHelper.Post
                        , url = "https://elm-graphql.onrender.com/api"
                        , body =
                            Http.jsonBody <|
                                Json.Encode.object
                                    [ ( "query", Json.Encode.string (Document.serializeQueryWithOperationName "OpName" queryDocument) )
                                    , ( "operationName", Json.Encode.string "OpName" )
                                    ]
                        }
        ]
