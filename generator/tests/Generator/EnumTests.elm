module Generator.EnumTests exposing (all)

import Expect
import Graphqelm.Generator.Enum as Enum
import Graphqelm.Parser.ClassCaseName as ClassCaseName
import Test exposing (Test, describe, test)


all : Test
all =
    describe "enum"
        [ test "generate enum" <|
            \() ->
                Enum.enumType (ClassCaseName.build "Beverage")
                    [ { name = ClassCaseName.build "Tea", description = Nothing }
                    , { name = ClassCaseName.build "Coffee", description = Nothing }
                    ]
                    |> Expect.equal """type Beverage
    = Tea
    | Coffee
"""
        ]
