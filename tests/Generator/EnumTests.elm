module Generator.EnumTests exposing (all)

import Expect
import GraphqElm.Generator.Enum as Enum
import Test exposing (Test, test)


all : Test
all =
    test "generate enum" <|
        \() ->
            Enum.enumType "Beverage" [ "Tea", "Coffee" ]
                |> Expect.equal """type Beverage
    = Tea
    | Coffee
"""
