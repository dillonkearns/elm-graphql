module Http.GraphqlErrorTests exposing (all)

import Dict
import Expect
import Graphql.Http.GraphqlError as GraphqlError
import Json.Decode
import Test exposing (Test, describe, test)


all : Test
all =
    describe "parser"
        [ test "error with location" <|
            \() ->
                """{"data":null,"errors":[{"message":"You must provide a `first` or `last` value to properly paginate the `releases` connection.","locations":[{"line":4,"column":5}]}]}"""
                    |> Json.Decode.decodeString GraphqlError.decoder
                    |> Expect.equal
                        (Ok
                            [ { message = "You must provide a `first` or `last` value to properly paginate the `releases` connection."
                              , locations = Just [ { line = 4, column = 5 } ]
                              , details = Dict.empty
                              }
                            ]
                        )
        , test "error without location" <|
            \() ->
                """{"data":null,"errors":[{"message":"Something went wrong while executing your query. Please include `94FE:5EA5:458434C:62871CD:5A44024B` when reporting this issue."}]}
"""
                    |> Json.Decode.decodeString GraphqlError.decoder
                    |> Expect.equal
                        (Ok
                            [ { message = "Something went wrong while executing your query. Please include `94FE:5EA5:458434C:62871CD:5A44024B` when reporting this issue."
                              , locations = Nothing
                              , details = Dict.fromList []
                              }
                            ]
                        )
        ]
