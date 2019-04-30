module QueryParserTests exposing (all)

import Expect
import Graphql.QueryParser exposing (..)
import Json.Decode as Decode exposing (Decoder)
import Parser
import Test exposing (Test, describe, only, test)


all : Test
all =
    describe "parser - top-level"
        [ test "parse anything" <|
            \() ->
                """
                 query {
                   foo {
                     bar
                   }
                 }
               """
                    |> Parser.run Graphql.QueryParser.parser
                    |> Expect.equal
                        (Ok
                            (Operation
                                { type_ = Query
                                , name = Nothing
                                , selectionSet =
                                    [ Field
                                        { alias = Nothing
                                        , name = "foo"
                                        , selectionSet =
                                            Just
                                                [ Field
                                                    { alias = Nothing
                                                    , name = "bar"
                                                    , selectionSet = Nothing
                                                    }
                                                ]
                                        }
                                    ]
                                }
                            )
                        )
        ]
