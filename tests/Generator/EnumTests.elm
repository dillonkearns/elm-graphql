module Generator.EnumTests exposing (all)

import Expect
import Graphqelm.Generator.Enum as Enum
import Test exposing (Test, describe, test)


all : Test
all =
    describe "enum"
        [ test "generate enum" <|
            \() ->
                Enum.enumType "Beverage"
                    [ { name = "Tea", description = Nothing }
                    , { name = "Coffee", description = Nothing }
                    ]
                    |> Expect.equal """type Beverage
    = Tea
    | Coffee
"""
        ]
