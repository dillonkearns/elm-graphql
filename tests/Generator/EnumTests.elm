module Generator.EnumTests exposing (all)

import Expect
import GraphqElm.Generator.Enum as Enum
import Test exposing (Test, describe, test)


all : Test
all =
    describe "enum"
        [ test "generate enum" <|
            \() ->
                Enum.enumType "Beverage" [ "Tea", "Coffee" ]
                    |> Expect.equal """type Beverage
    = Tea
    | Coffee
"""
        ]
