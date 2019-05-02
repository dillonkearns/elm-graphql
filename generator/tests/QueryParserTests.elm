module QueryParserTests exposing (all)

import Expect
import Graphql.QueryParser exposing (..)
import Json.Decode as Decode exposing (Decoder)
import Parser exposing (..)
import Test exposing (Test, describe, only, test)


all : Test
all =
    describe "parser - top-level"
        [ test "parse ba" <|
            \() ->
                """
                 query {
                   foo(id: 5) {
                     bar
                     baz(name: $flup)
                   }
                 }
               """
                    |> Graphql.QueryParser.parse
                    |> Expect.equal
                        (Ok
                            (Operation
                                { type_ = Query
                                , name = Nothing
                                , selectionSet =
                                    [ Field
                                        { alias = Nothing
                                        , name = "foo"
                                        , arguments = [{ name = "id", value = IntValue 5}]
                                        , selectionSet =
                                            Just
                                                [ Field
                                                    { alias = Nothing
                                                    , name = "bar"
                                                    , arguments = []
                                                    , selectionSet = Nothing
                                                    }
                                                ,  Field
                                                    { alias = Nothing
                                                    , name = "baz"
                                                    , arguments = [{name = "name", value = Variable "flup"}]
                                                    , selectionSet = Nothing
                                                    }
                                                ]
                                        }
                                    ]
                                }
                            )
                        )
        ]
