module Generator.NormalizeTests exposing (all)

import Expect
import Test exposing (Test, describe, test)


fieldName : String -> String
fieldName name =
    name


all : Test
all =
    describe "normalize"
        [ test "leaves valid names untouched" <|
            \() ->
                fieldName "validFieldName"
                    |> Expect.equal "validFieldName"
        ]
