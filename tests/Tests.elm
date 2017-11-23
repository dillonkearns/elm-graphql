module Tests exposing (..)

import Expect
import GraphqElm.Field as Field
import Json.Decode
import Schema.Human as Human
import Test exposing (..)


type alias Human =
    { name : String }


query : Field.FieldDecoder { name : String }
query =
    Human.human Human { id = "1000" } []
        |> Field.with Human.name


all : Test
all =
    describe "GraphqElm"
        [ test "generate query document" <|
            \_ ->
                Field.fieldDecoderToQuery query
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
                    |> Json.Decode.decodeString (Field.decoder query)
                    |> Expect.equal
                        (Ok { name = "Luke Skywalker" })
        ]
