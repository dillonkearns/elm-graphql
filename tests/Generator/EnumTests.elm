module Generator.EnumTests exposing (all)

import Expect
import Graphqelm.Generator.Enum as Enum
import Graphqelm.Parser.EnumName as EnumName
import Test exposing (Test, describe, test)


all : Test
all =
    describe "enum"
        [ test "generate enum" <|
            \() ->
                Enum.enumType "Beverage"
                    [ { name = EnumName.enumName "Tea", description = Nothing }
                    , { name = EnumName.enumName "Coffee", description = Nothing }
                    ]
                    |> Expect.equal """type Beverage
    = Tea
    | Coffee
"""
        ]
