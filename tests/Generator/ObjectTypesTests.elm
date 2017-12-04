module Generator.ObjectTypesTests exposing (all)

import Expect
import Graphqelm.Generator.ObjectTypes as ObjectTypes
import Test exposing (..)


definitions : List a
definitions =
    []


all : Test
all =
    describe "group"
        [ test "scalar has no imports" <|
            \() ->
                definitions
                    |> ObjectTypes.generate
                    |> Expect.equal """module Api.Object exposing (..)


type Character
    = Character
"""
        ]
