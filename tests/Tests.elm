module Tests exposing (..)

import Expect
import GraphqElm.Field as Field
import Json.Decode
import Schema.Human as Human
import Test exposing (..)


query : Field.Field
query =
    Human.human { id = "1000" } [] [ Human.name ]


all : Test
all =
    describe "GraphqElm"
        [ test "generate query document" <|
            \_ ->
                Field.toQuery query
                    |> Expect.equal
                        """{
human(id: "1000") {
name
}
}"""
        , test "decodes properly" <|
            \() ->
                """{
  "data": {
    "human": {
      "name": "Luke Skywalker"
    }
  }
}"""
                    |> Json.Decode.decodeString decoder
                    |> Expect.equal
                        (Ok (Human { name = "Luke Skywalker" }))
        ]


type Human
    = Human { name : String }


decoder : Json.Decode.Decoder a
decoder =
    Json.Decode.fail ""
