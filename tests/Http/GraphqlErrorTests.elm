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
                              , extensions = Nothing
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
                              , extensions = Nothing
                              }
                            ]
                        )
        , test "error without data field" <|
            -- you can have an "error" field with no "data" field
            -- in the case that no execution occurred
            -- see: https://github.com/dillonkearns/elm-graphql/issues/168
            \() ->
                """{"errors":[{"message":"Something went wrong while executing your query. Please include `94FE:5EA5:458434C:62871CD:5A44024B` when reporting this issue."}]}
              """
                    |> Json.Decode.decodeString GraphqlError.decoder
                    |> Expect.equal
                        (Ok
                            [ { message = "Something went wrong while executing your query. Please include `94FE:5EA5:458434C:62871CD:5A44024B` when reporting this issue."
                              , locations = Nothing
                              , details = Dict.fromList []
                              , extensions = Nothing
                              }
                            ]
                        )
        , test "error with extensions" <|
            \() ->
                """{"data":null,"errors":[{"message":"Something went wrong while executing your query","extensions":{"code": "CAN_NOT_FETCH_BY_ID","context":{"severity":"fatal"}}}]}
                  """
                    |> Json.Decode.decodeString GraphqlError.decoder
                    |> Result.map (List.map decodeExtensions)
                    |> Expect.equal
                        (Ok
                            [ Ok
                                { code = "CAN_NOT_FETCH_BY_ID"
                                , context =
                                    { severity = "fatal" }
                                }
                            ]
                        )
        ]


type alias ErrorExtensions =
    { code : String
    , context : ErrorContext
    }


type alias ErrorContext =
    { severity : String }


decodeExtensions : GraphqlError.GraphqlError -> Result String ErrorExtensions
decodeExtensions error =
    case error.extensions of
        Just extensions ->
            let
                codeResult =
                    Dict.get "code" extensions
                        |> Result.fromMaybe "no code"
                        |> Result.andThen (Json.Decode.decodeValue Json.Decode.string >> Result.mapError Json.Decode.errorToString)

                contextResult =
                    Dict.get "context" extensions
                        |> Result.fromMaybe "no context"
                        |> Result.andThen (Json.Decode.decodeValue contextDecoder >> Result.mapError Json.Decode.errorToString)
            in
            Result.map2 ErrorExtensions codeResult contextResult

        Nothing ->
            Err "no extensions"


contextDecoder : Json.Decode.Decoder ErrorContext
contextDecoder =
    Json.Decode.map ErrorContext
        (Json.Decode.field "severity" Json.Decode.string)
