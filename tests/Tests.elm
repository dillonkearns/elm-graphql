module Tests exposing (..)

import Expect
import GraphqElm.Field as Field
import Schema.Human as Human
import Test exposing (..)


query : Field.Field
query =
    Human.human [] [ Human.name ]


all : Test
all =
    describe "GraphqElm"
        [ test "generate query document" <|
            \_ ->
                Field.toQuery query
                    |> Expect.equal
                        """{
human {
name
}
}"""
        ]
